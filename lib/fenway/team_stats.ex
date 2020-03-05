defmodule Fenway.TeamStats do
  defstruct [:errors, :hits, :innings, :runs]

  def parse(json, team) when team == "home" or team == "away" do
    %__MODULE__{hits: retrieve(json, :hits, team),
                innings: retrieve(json, :innings, team),
                runs: retrieve(json, :runs, team),
                errors: retrieve(json, :errors, team),
    }
  end

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
