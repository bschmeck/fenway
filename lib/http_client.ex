defmodule HttpClient do
  def get(url) do
    case HTTPoison.get! url do
      %HTTPoison.Response{status_code: 200, body: body} -> {:ok, body}
      %HTTPoison.Response{status_code: code, body: body} -> {:error, code, body}
    end
  end
end
