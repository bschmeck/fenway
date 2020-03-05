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
end
