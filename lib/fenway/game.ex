defmodule Fenway.Game do
  defstruct [:at_bat, :away_errors, :away_hits, :away_innings, :away_runs, :balls, :home_errors, :home_hits, :home_innings, :home_runs, :outs, :strikes]

  def get(game_id) do
    {:ok, json} = Fetcher.fetch(game_id, FileClient)

    parse(json)
  end

  def parse(json) do
    %__MODULE__{at_bat: retrieve(json, :batter_number),
                balls: retrieve(json, :balls),
                strikes: retrieve(json, :strikes),
                outs: retrieve(json, :outs),
                home_hits: retrieve(json, :hits, "home"),
                home_innings: retrieve(json, :innings, "home"),
                home_runs: retrieve(json, :runs, "home"),
                home_errors: retrieve(json, :errors, "home"),
                away_hits: retrieve(json, :hits, "away"),
                away_innings: retrieve(json, :innings, "away"),
                away_runs: retrieve(json, :runs, "away"),
                away_errors: retrieve(json, :errors, "away")
    }
  end

  defp retrieve(json, :batter_number) do
    batter_id = dig(json, ~w[liveData linescore offense batter id])

    raw = dig(json, ["gameData", "players", "ID#{batter_id}", "primaryNumber"])

    case Integer.parse(raw) do
      {n, ""} -> n
      _ -> nil
    end
  end

  defp retrieve(%{"liveData" => %{"plays" => %{"currentPlay" => %{"count" => count}}}}, :balls), do: Map.get(count, "balls")
  defp retrieve(%{"liveData" => %{"plays" => %{"currentPlay" => %{"count" => count}}}}, :outs), do: Map.get(count, "outs")
  defp retrieve(%{"liveData" => %{"plays" => %{"currentPlay" => %{"count" => count}}}}, :strikes), do: Map.get(count, "strikes")
  defp retrieve(json, path) when is_list(path), do: dig(json, path)
  defp retrieve(json, :hits, team) when team == "home" or team == "away", do: retrieve(json, path_to(:hits, team))
  defp retrieve(json, :runs, team) when team == "home" or team == "away", do: retrieve(json, path_to(:runs, team))
  defp retrieve(json, :errors, team) when team == "home" or team == "away", do: retrieve(json, path_to(:errors, team))
  defp retrieve(%{"liveData" => %{"linescore" => %{"innings" => innings}}}, :innings, team) when team == "home" or team == "away" do
    Enum.map(innings, fn (hash) -> dig(hash, [team, "runs"]) end)
  end

  defp path_to(:errors, team), do: team_stats_path(team, "fielding", "errors")
  defp path_to(:hits, team), do: team_stats_path(team, "batting", "hits")
  defp path_to(:runs, team), do: team_stats_path(team, "batting", "runs")

  defp team_stats_path(team, category, stat), do: ["liveData", "boxscore", "teams", team, "teamStats", category, stat]

  defp dig(value, []), do: value
  defp dig(map, [key | rest]), do: map |> Map.get(key) |> dig(rest)
end
