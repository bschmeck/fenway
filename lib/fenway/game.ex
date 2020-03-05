defmodule Fenway.Game do
  defstruct [:at_bat, :away_stats, :balls, :home_stats, :outs, :strikes]

  def get(game_id) do
    {:ok, json} = Fetcher.fetch(game_id, FileClient)

    parse(json)
  end

  def parse(json) do
    %__MODULE__{at_bat: retrieve(json, :batter_number),
                balls: retrieve(json, :balls),
                strikes: retrieve(json, :strikes),
                outs: retrieve(json, :outs),
                home_stats: Fenway.TeamStats.parse(json, "home"),
                away_stats: Fenway.TeamStats.parse(json, "away")
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

  defp dig(value, []), do: value
  defp dig(map, [key | rest]), do: map |> Map.get(key) |> dig(rest)
end
