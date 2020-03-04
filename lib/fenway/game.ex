defmodule Fenway.Game do
  defstruct [:at_bat, :balls, :outs, :strikes]

  def get(game_id) do
    {:ok, json} = Fetcher.fetch(game_id, FileClient)

    %__MODULE__{at_bat: batter_number(json),
                balls: balls(json),
                strikes: strikes(json),
                outs: outs(json)}
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

  defp dig(value, []), do: value
  defp dig(map, [key | rest]), do: map |> Map.get(key) |> dig(rest)
end
