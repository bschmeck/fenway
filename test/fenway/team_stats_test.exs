defmodule Fenway.TeamStatsTest do
  use ExUnit.Case, async: true

  @json_feed "test/sox_game.json"

  setup_all do
    {:ok, raw} = File.read(@json_feed)

    [json: Jason.decode!(raw)]
  end

  test "it retrieves the number of runs the away team has scored", context do
    assert Fenway.TeamStats.parse(context[:json], "away").runs == 1
  end

  test "it retrieves the number of hits the away team has", context do
    assert Fenway.TeamStats.parse(context[:json], "away").hits == 3
  end

  test "it retrieves the number of errors the away team has committed", context do
    assert Fenway.TeamStats.parse(context[:json], "away").errors == 1
  end

  test "it retrieves the number of runs the home team has scored", context do
    assert Fenway.TeamStats.parse(context[:json], "home").runs == 1
  end

  test "it retrieves the number of hits the home team has", context do
    assert Fenway.TeamStats.parse(context[:json], "home").hits == 2
  end

  test "it retrieves the number of errors the home team has committed", context do
    assert Fenway.TeamStats.parse(context[:json], "home").errors == 0
  end

  test "it retrieves the away team's runs by inning", context do
    assert Fenway.TeamStats.parse(context[:json], "away").innings == [0, 1]
  end

  test "it retrieves the home team's runs by inning", context do
    assert Fenway.TeamStats.parse(context[:json], "home").innings == [1, nil]
  end
end
