defmodule Fenway.Scene.Monster do
  use Scenic.Scene

  alias Scenic.Graph
  alias Fenway.Component.Scoreboard

  @wall_color {84, 121, 109}

  def init(_, _opts) do
    graph = Graph.build(clear_color: @wall_color)
    |> Fenway.Component.Scoreboard.add_to_graph(:init_data, [])

    {:ok, graph, push: graph}
  end
end
