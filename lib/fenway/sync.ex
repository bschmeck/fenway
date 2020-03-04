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
  def handle_info(:tick, game_id) do
    # 1. Retrieve %Fenway.Game{} data from MLB
    # 2. Push game state to Scenic components
    # 2a. Is it preferable to push the whole game to the scoreboard and let it update components?
    # 3. Schedule next sync for the future
    game = Fenway.Game.get(game_id)

    [{pid, _}] = Registry.lookup(Registry.Components, "at_bat")
    GenServer.cast(pid, {:at_bat, game.at_bat})

    {:noreply, game_id}
  end
end
