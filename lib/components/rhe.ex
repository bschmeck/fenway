defmodule Fenway.Component.RHE do
  use Scenic.Component

  alias Scenic.Graph

  def info(_), do: "error"
  def verify(data), do: {:ok, data}

  def init({name, {runs, hits, errors}}, _opts) do
    {:ok, _} = Registry.register(Registry.Components, name, [])

    {:ok, %{}, push: graph_for({runs, hits, errors})}
  end

  def handle_cast({:rhe, {runs, hits, errors}}, state) do
    {:noreply, state, [push: graph_for({runs, hits, errors})]}
  end

  defp graph_for({runs, hits, errors}) do
    Graph.build([])
    |> Fenway.Component.Number.add_to_graph(runs)
    |> Fenway.Component.Number.add_to_graph(hits, translate: {65, 0})
    |> Fenway.Component.Number.add_to_graph(errors, translate: {130, 0})
  end
end
