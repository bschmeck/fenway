defmodule FileClient do
  def get(_) do
    File.read("test/sox_game.json")
  end
end
