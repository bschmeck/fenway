defmodule Fenway.Component.Number do
  use Scenic.Component

  import Scenic.Primitives
  alias Scenic.Graph

  @border_color :black

  def info(_), do: "error"
  def verify(data), do: {:ok, data}

  def init({name, number}, _opts) do
    {:ok, _} = Registry.register(Registry.Components, name, [])

    {:ok, %{}, push: graph_for(number)}
  end
  def init(number, _opts) do
    {:ok, %{}, push: graph_for(number)}
  end

  def handle_cast({:number, number}, state) do
    {:noreply, state, [push: graph_for(number)]}
  end

  defp graph_for(:blank) do
    Graph.build([])
    |> rectangle({30, 40}, stroke: {1, @border_color})
  end
  defp graph_for(number) when number >= 0 and number <= 99 do
    graph_for(:blank)
    |> text("#{number}", opts_for(number))
  end

  defp opts_for(n) when n >= 0 and n <= 9, do: [fill: :white, font_size: 40, translate: {5, 32}]
  defp opts_for(n) when n >= 10 and n <= 99, do: [fill: :white, font_size: 32, translate: {0, 32}]
end
