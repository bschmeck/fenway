defmodule Fenway.Game do
  defstruct [:at_bat]

  def get(_game_id) do
    %__MODULE__{at_bat: :rand.uniform(99) }
  end
end
