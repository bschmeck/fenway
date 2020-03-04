defmodule Fenway.Game do
  defstruct [:at_bat, :away_errors, :away_hits, :away_runs, :balls, :home_errors, :home_hits, :home_runs, :outs, :strikes]

  def get(game_id) do
    {:ok, json} = Fetcher.fetch(game_id, FileClient)

    parse(json)
  end

  def parse(json) do
    %__MODULE__{at_bat: retrieve(json, :batter_number),
                balls: retrieve(json, :balls),
                strikes: retrieve(json, :strikes),
                outs: retrieve(json, :outs),
                home_hits: retrieve(json, :home_hits),
                home_runs: retrieve(json, :home_runs),
                home_errors: retrieve(json, :home_errors),
                away_hits: retrieve(json, :away_hits),
                away_runs: retrieve(json, :away_runs),
                away_errors: retrieve(json, :away_errors)
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

  defp retrieve(json, path) when is_list(path), do: dig(json, path)
  defp retrieve(json, :balls), do: retrieve(json, path_to(:balls))
  defp retrieve(json, :outs), do: retrieve(json, path_to(:outs))
  defp retrieve(json, :strikes), do: retrieve(json, path_to(:strikes))
  defp retrieve(json, :away_errors), do: retrieve(json, path_to(:away_errors))
  defp retrieve(json, :away_hits), do: retrieve(json, path_to(:away_hits))
  defp retrieve(json, :away_runs), do: retrieve(json, path_to(:away_runs))
  defp retrieve(json, :home_errors), do: retrieve(json, path_to(:home_errors))
  defp retrieve(json, :home_hits), do: retrieve(json, path_to(:home_hits))
  defp retrieve(json, :home_runs), do: retrieve(json, path_to(:home_runs))

  defp path_to(:balls), do: ~w[liveData plays currentPlay count balls]
  defp path_to(:outs), do: ~w[liveData plays currentPlay count outs]
  defp path_to(:strikes), do: ~w[liveData plays currentPlay count strikes]
  defp path_to(:away_errors), do: ~w[liveData boxscore teams away teamStats fielding errors]
  defp path_to(:away_hits), do: ~w[liveData boxscore teams away teamStats batting hits]
  defp path_to(:away_runs), do: ~w[liveData boxscore teams away teamStats batting runs]
  defp path_to(:home_errors), do: ~w[liveData boxscore teams home teamStats fielding errors]
  defp path_to(:home_hits), do: ~w[liveData boxscore teams home teamStats batting hits]
  defp path_to(:home_runs), do: ~w[liveData boxscore teams home teamStats batting runs]

  defp dig(value, []), do: value
  defp dig(map, [key | rest]), do: map |> Map.get(key) |> dig(rest)
end
