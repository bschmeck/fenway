defmodule Fenway.Scene.Monster do
  use Scenic.Scene

  alias Scenic.Graph

  @wall_color {84, 121, 109}
  @scoreboard_color {73, 78, 68}

  def init(_, _opts) do
    graph = Graph.build(clear_color: @wall_color, fill: @scoreboard_color)

    {:ok, graph, push: graph}
  end
end
