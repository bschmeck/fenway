defmodule Fenway.Component.Scoreboard do
  use Scenic.Component

  import Scenic.Primitives
  alias Scenic.Graph

  def info(_), do: "error"
  def verify(data), do: {:ok, data}

  def init(_state, _opts) do
    graph = Graph.build([])
    |> rectangle({984, 560}, stroke: {10, :white}, translate: {20, 20})

    {:ok, %{}, push: graph}
  end
end
