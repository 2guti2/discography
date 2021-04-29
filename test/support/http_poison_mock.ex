defmodule Discography.Support.HttpPoisonMock do
  @moduledoc false

  def post(
        "https://api.trello.com/1/cards?idList=&key=c308982038e040387cd7fe3018e8ee3f&name=1974+-+Error" <>
          _,
        []
      ) do
    {:ok, %{status_code: 400}}
  end

  def post("https://api.trello.com/1/cards" <> _, []) do
    {:ok, %{status_code: 200, body: "good job"}}
  end

  def post("https://api.trello.com/1/lists" <> _, []) do
    body = %{"id" => "an-id"}
    {:ok, %{status_code: 200, body: Poison.encode!(body)}}
  end

  def post(_, _, _) do
    body = %{"access_token" => "abcdef"}

    {:ok, %{status_code: 200, body: Poison.encode!(body)}}
  end

  def put(_) do
    {:ok, %{status_code: 200, body: nil}}
  end

  def get("some-board-url.json" <> _) do
    body = %{"id" => "an-id"}
    {:ok, %{status_code: 200, body: Poison.encode!(body)}}
  end

  def get("https://api.trello.com/1/boards/an-id/lists" <> _) do
    {:ok, %{status_code: 200, body: Poison.encode!([%{"id" => "some-id"}])}}
  end

  def get("https://api.spotify.com/v1/search?type=album&q=Bob%20Dylan%20TestBreaker", _) do
    {:ok, %{status_code: 400}}
  end

  def get("https://api.spotify.com/v1/search?type=album&q=Bob%20Dylan%20ServerBreaker", _) do
    {:error, %{reason: "some reason"}}
  end

  def get(_, _) do
    body = %{
      "albums" => %{
        "items" => [
          %{
            "images" => [
              %{
                "url" => "http://someimageurl.com"
              }
            ]
          }
        ]
      }
    }

    {:ok, %{status_code: 200, body: Poison.encode!(body)}}
  end
end
