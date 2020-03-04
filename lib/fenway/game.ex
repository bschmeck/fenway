defmodule Fenway.Game do
  defstruct [:at_bat]

  def get(game_id) do
    {:ok, json} = Fetcher.fetch(game_id, FileClient)

    %__MODULE__{at_bat: batter_number(json)}
  end

  defp dig(value, []), do: value
  defp dig(map, [key | rest]), do: map |> Map.get(key) |> dig(rest)

  defp batter_number(json) do
    batter_id = dig(json, ~w[liveData linescore offense batter id])

    raw = dig(json, ["gameData", "players", "ID#{batter_id}", "primaryNumber"])

    case Integer.parse(raw) do
      {n, ""} -> n
      _ -> nil
    end
  end
end
