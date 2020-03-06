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
    notify("away_hits", {:number, game.away_stats.hits})
    notify("away_runs", {:number, game.away_stats.runs})
    notify("away_errors", {:number, game.away_stats.errors})
    notify("home_hits", {:number, game.home_stats.hits})
    notify("home_runs", {:number, game.home_stats.runs})
    notify("home_errors", {:number, game.home_stats.errors})
    notify_innings("home", game.home_stats.innings, 1)
    notify_innings("away", game.away_stats.innings, 1)

    {:noreply, game_id}
  end

  defp notify_innings(_, [], _), do: nil
  defp notify_innings(team, [runs | rest], inning) do
    notify("#{team}_#{inning}", {:number, runs || :blank})
    notify_innings(team, rest, inning + 1)
  end

  defp notify(name, msg) do
    case Registry.lookup(Registry.Components, name) do
      [{pid, _}] -> GenServer.cast(pid, msg)
      _ -> :no_op
    end
  end
end
