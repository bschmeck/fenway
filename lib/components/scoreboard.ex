defmodule Fenway.Component.Scoreboard do
  use Scenic.Component

  import Scenic.Primitives
  alias Scenic.Graph

  @scoreboard_color {68, 68, 65}

  def info(_), do: "error"
  def verify(data), do: {:ok, data}

  def init(_state, _opts) do
    graph = Graph.build([])
    |> rectangle({1010, 409}, stroke: {10, :white}, fill: @scoreboard_color, translate: {5, 5})
    |> rectangle({980, 10}, fill: :white, translate: {20, 248})
    |> rectangle({10, 306}, fill: :white, translate: {800, 78})
    |> Fenway.Component.AtBat.add_to_graph(0, translate: {120, 320})
    |> Fenway.Component.Indicator.add_to_graph([3, :blue], translate: {255, 360})
    |> Fenway.Component.Indicator.add_to_graph([2, :red], translate: {460, 360})
    |> Fenway.Component.Indicator.add_to_graph([2, :red], translate: {605, 360})
    |> text("AT BAT", fill: :white, font_size: 40, translate: {100, 318})
    |> text("BALL", fill: :white, font_size: 40, translate: {265, 318})
    |> text("STRIKE", fill: :white, font_size: 40, translate: {425, 318})
    |> text("OUT", fill: :white, font_size: 40, translate: {595, 318})

    {:ok, %{}, push: graph}
  end
end
