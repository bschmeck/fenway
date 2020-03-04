defmodule Fenway.Game do
  defstruct [:at_bat, :away_errors, :away_hits, :away_runs, :balls, :home_errors, :home_hits, :home_runs, :outs, :strikes]

  def get(game_id) do
    {:ok, json} = Fetcher.fetch(game_id, FileClient)

    %__MODULE__{at_bat: batter_number(json),
                balls: balls(json),
                strikes: strikes(json),
                outs: outs(json),
                home_hits: home_hits(json),
                home_runs: home_runs(json),
                home_errors: home_errors(json),
                away_hits: away_hits(json),
                away_runs: away_runs(json),
                away_errors: away_errors(json)
    }
  end

  defp batter_number(json) do
    batter_id = dig(json, ~w[liveData linescore offense batter id])

    raw = dig(json, ["gameData", "players", "ID#{batter_id}", "primaryNumber"])

    case Integer.parse(raw) do
      {n, ""} -> n
      _ -> nil
    end
  end

  defp balls(json) do
    dig(json, ~w[liveData plays currentPlay count balls])
  end

  defp outs(json) do
    dig(json, ~w[liveData plays currentPlay count outs])
  end

  defp strikes(json) do
    dig(json, ~w[liveData plays currentPlay count strikes])
  end

  defp away_errors(json) do
    dig(json, ~w[liveData boxscore teams away teamStats fielding errors])
  end

  defp home_errors(json) do
    dig(json, ~w[liveData boxscore teams home teamStats fielding errors])
  end

  defp away_runs(json) do
    dig(json, ~w[liveData boxscore teams away teamStats batting runs])
  end

  defp home_runs(json) do
    dig(json, ~w[liveData boxscore teams home teamStats batting runs])
  end

  defp away_hits(json) do
    dig(json, ~w[liveData boxscore teams away teamStats batting hits])
  end

  defp home_hits(json) do
    dig(json, ~w[liveData boxscore teams home teamStats batting hits])
  end

  defp dig(value, []), do: value
  defp dig(map, [key | rest]), do: map |> Map.get(key) |> dig(rest)
end
