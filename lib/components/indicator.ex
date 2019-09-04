defmodule Fenway.Component.Indicator do
  use Scenic.Component

  import Scenic.Primitives
  alias Scenic.Graph

  @ball_color :blue
  @strike_color :red

  def info(_), do: "error"
  def verify(data), do: {:ok, data}

  def init([num_lights, color], _opts) do
    graph = Graph.build([])
    |> add_lights(num_lights, color)

    {:ok, %{num_lights: num_lights, color: color}, push: graph}
  end

  defp add_lights(graph, 0, _color), do: graph
  defp add_lights(graph, n, color) do
    circle(graph, 15, fill: color, translate: { 45 * (n-1), 0})
    |> add_lights(n - 1, color)
  end
end
