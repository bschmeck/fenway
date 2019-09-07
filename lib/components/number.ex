defmodule Fenway.Component.Number do
  use Scenic.Component

  import Scenic.Primitives
  alias Scenic.Graph

  @border_color :black

  def info(_), do: "error"
  def verify(data), do: {:ok, data}

  def init(_number, _opts) do
    graph = Graph.build([])
    |> rectangle({30, 40}, stroke: {1, @border_color})

    {:ok, %{}, push: graph}
  end
end
