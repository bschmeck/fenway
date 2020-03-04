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

    notify("at_bat", {:at_bat, game.at_bat})
    notify("count", {:count, {game.balls, game.strikes, game.outs}})

    {:noreply, game_id}
  end

  defp notify(name, msg) do
    case Registry.lookup(Registry.Components, name) do
      [{pid, _}] -> GenServer.cast(pid, msg)
      _ -> :no_op
    end
  end
end
