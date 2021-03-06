defmodule Fenway.Component.AtBat do
  use Scenic.Component

  import Scenic.Primitives
  alias Scenic.Graph

  @bulb_on_color :yellow
  @bulb_off_color :dark_gray

  def info(_), do: "error"
  def verify(data), do: {:ok, data}

  def init({name, number}, _opts) do
    graph = graph_for(number)

    {:ok, _} = Registry.register(Registry.Components, name, [])

    {:ok, %{number: number}, push: graph}
  end

  def handle_cast({:at_bat, number}, state) do
    {:noreply, state, [push: graph_for(number)]}
  end

  defp graph_for(number) when number < 10, do: graph_for(:off, number)
  defp graph_for(number) when number < 100, do: graph_for(div(number, 10), rem(number, 10))
  defp graph_for(_), do: graph_for(:off, :off)
  defp graph_for(digit_1, digit_2) do
    Graph.build([])
    |> group(fn(graph) -> digit(graph, digit_1) end)
    |> group(fn(graph) -> digit(graph, digit_2) end, translate: {46, 0})
  end

  defp digit(graph, number) do
    graph
    |> rectangle({36, 63}, fill: :gray)
    |> circle_at({0, 0}, number)
    |> circle_at({1, 0}, number)
    |> circle_at({2, 0}, number)
    |> circle_at({3, 0}, number)
    |> circle_at({0, 1}, number)
    |> circle_at({3, 1}, number)
    |> circle_at({0, 2}, number)
    |> circle_at({3, 2}, number)
    |> circle_at({0, 3}, number)
    |> circle_at({1, 3}, number)
    |> circle_at({2, 3}, number)
    |> circle_at({3, 3}, number)
    |> circle_at({0, 4}, number)
    |> circle_at({3, 4}, number)
    |> circle_at({0, 5}, number)
    |> circle_at({3, 5}, number)
    |> circle_at({0, 6}, number)
    |> circle_at({1, 6}, number)
    |> circle_at({2, 6}, number)
    |> circle_at({3, 6}, number)
  end

  defp circle_at(graph, {x, y}, number) do
    circle(graph, 4, fill: color_at({x, y}, number), translate: {9 * x + 4, 9 * y + 4})
  end

  defp color_at(_, :off), do: @bulb_off_color

  defp color_at({1, 3}, 0), do: @bulb_off_color
  defp color_at({2, 3}, 0), do: @bulb_off_color
  defp color_at(_, 0), do: @bulb_on_color

  defp color_at({3, _}, 1), do: @bulb_on_color

  defp color_at({0, 1}, 2), do: @bulb_off_color
  defp color_at({0, 2}, 2), do: @bulb_off_color
  defp color_at({0, 3}, 2), do: @bulb_off_color
  defp color_at({3, 4}, 2), do: @bulb_off_color
  defp color_at({3, 5}, 2), do: @bulb_off_color
  defp color_at(_, 2), do: @bulb_on_color

  defp color_at({0, 0}, 3), do: @bulb_on_color
  defp color_at({0, 6}, 3), do: @bulb_on_color
  defp color_at({0, _}, 3), do: @bulb_off_color
  defp color_at(_, 3), do: @bulb_on_color

  defp color_at({0, 1}, 4), do: @bulb_on_color
  defp color_at({0, 2}, 4), do: @bulb_on_color
  defp color_at({3, _}, 4), do: @bulb_on_color
  defp color_at({_, 3}, 4), do: @bulb_on_color

  defp color_at({3, 1}, 5), do: @bulb_off_color
  defp color_at({3, 2}, 5), do: @bulb_off_color
  defp color_at({0, 4}, 5), do: @bulb_off_color
  defp color_at({0, 5}, 5), do: @bulb_off_color
  defp color_at(_, 5), do: @bulb_on_color

  defp color_at({3, 1}, 6), do: @bulb_off_color
  defp color_at({3, 2}, 6), do: @bulb_off_color
  defp color_at(_, 6), do: @bulb_on_color

  defp color_at({_, 0}, 7), do: @bulb_on_color
  defp color_at({3, _}, 7), do: @bulb_on_color

  defp color_at(_, 8), do: @bulb_on_color

  defp color_at({_, 0}, 9), do: @bulb_on_color
  defp color_at({_, 1}, 9), do: @bulb_on_color
  defp color_at({_, 2}, 9), do: @bulb_on_color
  defp color_at({_, 3}, 9), do: @bulb_on_color
  defp color_at({3, _}, 9), do: @bulb_on_color


  defp color_at(_, _), do: @bulb_off_color
end
