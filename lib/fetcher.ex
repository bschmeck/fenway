defmodule Fetcher do
  def fetch(game_id, client \\ HttpClient) do
    uri = "https://statsapi.mlb.com/api/v1.1/game/#{game_id}/feed/live"

    {:ok, body} = client.get(uri)
    Jason.decode!(body)
  end
end
