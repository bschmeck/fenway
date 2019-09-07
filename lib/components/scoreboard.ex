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
    |> text("F", fill: :white, font_size: 40, translate: {207, 60})
    |> text("E", fill: :white, font_size: 40, translate: {267, 60})
    |> text("N", fill: :white, font_size: 40, translate: {327, 60})
    |> text("W", fill: :white, font_size: 40, translate: {387, 60})
    |> text("A", fill: :white, font_size: 40, translate: {447, 60})
    |> text("Y", fill: :white, font_size: 40, translate: {507, 60})
    |> text("P", fill: :white, font_size: 40, translate: {615, 60})
    |> text("A", fill: :white, font_size: 40, translate: {670, 60})
    |> text("R", fill: :white, font_size: 40, translate: {725, 60})
    |> text("K", fill: :white, font_size: 40, translate: {780, 60})
    |> text("P", fill: :white, font_size: 40, translate: {100, 100})
    |> text("1", fill: :white, font_size: 40, translate: {320, 100})
    |> text("2", fill: :white, font_size: 40, translate: {360, 100})
    |> text("3", fill: :white, font_size: 40, translate: {400, 100})
    |> text("4", fill: :white, font_size: 40, translate: {470, 100})
    |> text("5", fill: :white, font_size: 40, translate: {510, 100})
    |> text("6", fill: :white, font_size: 40, translate: {550, 100})
    |> text("7", fill: :white, font_size: 40, translate: {620, 100})
    |> text("8", fill: :white, font_size: 40, translate: {660, 100})
    |> text("9", fill: :white, font_size: 40, translate: {700, 100})
    |> text("10", fill: :white, font_size: 40, translate: {755, 100})
    |> text("R", fill: :white, font_size: 40, translate: {835, 100})
    |> text("H", fill: :white, font_size: 40, translate: {900, 100})
    |> text("E", fill: :white, font_size: 40, translate: {965, 100})

    {:ok, %{}, push: graph}
  end
end
