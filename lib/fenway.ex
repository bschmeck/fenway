defmodule Fenway do
  @moduledoc """
  Starter application using the Scenic framework.
  """

  def start(_type, _args) do
    # load the viewport configuration from config
    main_viewport_config = Application.get_env(:fenway, :viewport)

    # start the application with the viewport
    children = [
      {Registry, keys: :unique, name: Registry.Components},
      {Scenic, viewports: [main_viewport_config]},
      {Fenway.Sync, [0]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
