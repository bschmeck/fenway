defmodule Fetcher do
  def fetch(game_id, client \\ HttpClient) do
    uri = "https://statsapi.mlb.com/api/v1.1/game/#{game_id}/feed/live"

    case client.get(uri) do
      {:ok, body} -> {:ok, Jason.decode!(body)}
      {:error, code, body} -> {:error, code, Jason.decode!(body)}
    end
  end
end
