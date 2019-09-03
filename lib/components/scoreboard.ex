defmodule Fenway.Component.Scoreboard do
  use Scenic.Component

  import Scenic.Primitives
  alias Scenic.Graph

  @scoreboard_color {73, 78, 68}

  def info(_), do: "error"
  def verify(data), do: {:ok, data}

  def init(_state, _opts) do
    graph = Graph.build([])
    |> rectangle({984, 560}, stroke: {10, :white}, fill: @scoreboard_color, translate: {20, 20})
    |> Fenway.Component.AtBat.add_to_graph(0, [])

    {:ok, %{}, push: graph}
  end
end
