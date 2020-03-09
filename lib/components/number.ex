defmodule Fenway.Component.Number do
  use Scenic.Component

  import Scenic.Primitives
  alias Scenic.Graph

  @border_color :black
  @active_color :yellow
  @inactive_color :white

  def info(_), do: "error"
  def verify(data), do: {:ok, data}

  def init({name, number}, _opts) do
    {:ok, _} = Registry.register(Registry.Components, name, [])

    {:ok, number, push: graph_for(number)}
  end
  def init(number, _opts) do
    {:ok, number, push: graph_for(number)}
  end

  def handle_cast({:number, number}, _state) do
    {:noreply, number, [push: graph_for(number)]}
  end

  def handle_cast(:active, number) do
    {:noreply, number, [push: graph_for(number, @active_color)]}
  end

  defp graph_for(number, color \\ @inactive_color)
  defp graph_for(:blank, _color) do
    Graph.build([])
    |> rectangle({30, 40}, stroke: {1, @border_color})
  end
  defp graph_for(number, color) when number >= 0 and number <= 99 do
    graph_for(:blank)
    |> text("#{number}", opts_for(number, color))
  end

  defp opts_for(n, color) when n >= 0 and n <= 9, do: [fill: color, font_size: 40, translate: {5, 32}]
  defp opts_for(n, color) when n >= 10 and n <= 99, do: [fill: color, font_size: 32, translate: {0, 32}]
end
