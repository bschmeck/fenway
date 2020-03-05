defmodule Fenway.Game do
  defstruct [:at_bat, :away_stats, :balls, :home_stats, :outs, :pitcher, :strikes]

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
                away_stats: Fenway.TeamStats.parse(json, "away"),
                pitcher: retrieve(json, :pitcher_number)
    }
  end

  defp retrieve(%{"liveData" => %{"linescore" => %{"defense" => %{"pitcher" => %{"id" => pitcher_id}}}}} = json, :pitcher_number), do: player_number(json, pitcher_id)
  defp retrieve(%{"liveData" => %{"linescore" => %{"offense" => %{"batter" => %{"id" => batter_id}}}}} = json, :batter_number), do: player_number(json, batter_id)
  defp retrieve(%{"liveData" => %{"plays" => %{"currentPlay" => %{"count" => count}}}}, :balls), do: Map.get(count, "balls")
  defp retrieve(%{"liveData" => %{"plays" => %{"currentPlay" => %{"count" => count}}}}, :outs), do: Map.get(count, "outs")
  defp retrieve(%{"liveData" => %{"plays" => %{"currentPlay" => %{"count" => count}}}}, :strikes), do: Map.get(count, "strikes")

  defp player_number(json, player_id) do
    # Elixir complains about using a variable during pattern matching if we try to use this interpolated value directly
    # when destructuring json.
    key = "ID#{player_id}"
    %{"gameData" => %{"players" => %{^key => %{"primaryNumber" => raw}}}} = json

    case Integer.parse(raw) do
      {n, ""} -> n
      _ -> nil
    end
  end
end
