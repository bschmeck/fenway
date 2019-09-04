defmodule Fenway.Component.AtBat do
  use Scenic.Component

  import Scenic.Primitives
  alias Scenic.Graph

  @bulb_on_color :yellow
  @bulb_off_color :dark_gray

  def info(_), do: "error"
  def verify(data), do: {:ok, data}

  def init(number, _opts) do
    graph = graph_for(number)

    {:ok, _timer} = :timer.send_interval(:timer.seconds(2), :tick)

    {:ok, %{number: number}, push: graph}
  end

  def handle_info(:tick, %{number: number}) do
    number = rem(number + 1, 10)

    {:noreply, %{number: number}, [push: graph_for(number)]}
  end

  defp graph_for(number) do
    Graph.build([])
    |> group(fn(graph) ->
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
    end)
    |> group(fn(graph) ->
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
    end, translate: {46, 0})
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
