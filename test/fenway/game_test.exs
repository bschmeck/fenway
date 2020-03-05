defmodule Fenway.GameTest do
  use ExUnit.Case, async: true

  @json_feed "test/sox_game.json"

  setup_all do
    {:ok, raw} = File.read(@json_feed)

    [json: Jason.decode!(raw)]
  end

  test "it retrieves the number of the player at bat", context do
    assert %{at_bat: 39} = Fenway.Game.parse(context[:json])
  end

  test "it retrieves the number of balls", context do
    assert %{balls: 0} = Fenway.Game.parse(context[:json])
  end

  test "it retrieves the number of strikes", context do
    assert %{strikes: 0} = Fenway.Game.parse(context[:json])
  end

  test "it retrieves the number of outs", context do
    assert %{outs: 2} = Fenway.Game.parse(context[:json])
  end

  test "it retrieves the number of runs the away team has scored", context do
    assert %{away_runs: 1} = Fenway.Game.parse(context[:json])
  end

  test "it retrieves the number of hits the away team has", context do
    assert %{away_hits: 3} = Fenway.Game.parse(context[:json])
  end

  test "it retrieves the number of errors the away team has committed", context do
    assert %{away_errors: 1} = Fenway.Game.parse(context[:json])
  end

  test "it retrieves the number of runs the home team has scored", context do
    assert %{home_runs: 1} = Fenway.Game.parse(context[:json])
  end

  test "it retrieves the number of hits the home team has", context do
    assert %{home_hits: 2} = Fenway.Game.parse(context[:json])
  end

  test "it retrieves the number of errors the home team has committed", context do
    assert %{home_errors: 0} = Fenway.Game.parse(context[:json])
  end

  test "it retrieves the away team's runs by inning", context do
    assert %{away_innings: [0, 1]} = Fenway.Game.parse(context[:json])
  end

  test "it retrieves the home team's runs by inning", context do
    assert %{home_innings: [1, nil]} = Fenway.Game.parse(context[:json])
  end
end
