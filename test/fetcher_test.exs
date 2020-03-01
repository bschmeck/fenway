defmodule FetcherTest do
  use ExUnit.Case

  test "it returns parsed JSON" do
    assert %{} = Fetcher.fetch(604058)
  end
end
