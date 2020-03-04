defmodule Fenway.Component.Count do
  use Scenic.Component

  import Scenic.Primitives
  alias Scenic.Graph

  def info(_), do: "error"
  def verify(data), do: {:ok, data}

  def init(count, _opts) do
    graph = graph_for(count)

    {:ok, _} = Registry.register(Registry.Components, "count", [])

    {:ok, %{count: count}, push: graph}
  end

  defp graph_for({balls, strikes, outs})  when balls >= 0 and balls <= 3 and strikes >= 0 and strikes <= 2 and outs >= 0 and outs <= 2 do
    Graph.build([])
    |> group(fn(graph) -> indicators(graph, 3, balls, :blue, {:blue, 128}) end)
    |> group(fn(graph) -> indicators(graph, 2, strikes, :red, {:red, 128}) end, translate: {205, 0})
    |> group(fn(graph) -> indicators(graph, 2, outs, :red, {:red, 128}) end, translate: {350, 0})
  end

  defp indicators(graph, total, on, on_color, off_color) do
    color_list = colors(total, on, on_color, off_color, [])
    lights(graph, 0, color_list)
  end

  defp colors(0, _, _, _, ret), do: ret |> Enum.reverse
  defp colors(total, 0, _, off_color, l), do: colors(total - 1, 0, nil, off_color, [off_color | l])
  defp colors(total, on, on_color, off_color, l), do: colors(total - 1, on - 1, on_color, off_color, [on_color | l])

  defp lights(graph, _n, []), do: graph
  defp lights(graph, n, [color | rest]) do
    graph
    |> circle(15, fill: color, translate: { 45 * n, 0 })
    |> lights(n + 1, rest)
  end
end
