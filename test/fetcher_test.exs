defmodule FetcherTest do
  use ExUnit.Case, async: true

  test "it returns parsed JSON" do
    assert {:ok, %{}} = Fetcher.fetch(604058)
  end

  test "it returns an error when given an invalid game id" do
    assert {:error, 400, %{}} = Fetcher.fetch("invalid")
  end

  test "it returns an error when given a non-existent game id" do
    assert {:error, 404, %{}} = Fetcher.fetch(999999)
  end
end
