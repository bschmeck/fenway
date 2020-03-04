defmodule Fenway.Sync do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init([n]) do
    {:ok, _timer} = :timer.send_interval(:timer.seconds(2), :tick)
    {:ok, n}
  end

  @impl true
  def handle_info(:tick, n) do
    [{pid, _}] = Registry.lookup(Registry.Components, "at_bat")
    GenServer.cast(pid, {:at_bat, n})

    {:noreply, n + 1}
  end
end
