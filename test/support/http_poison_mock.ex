defmodule Discography.Support.HttpPoisonMock do
  @moduledoc false

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

  def post(_, _, _) do
    body = %{"access_token" => "abcdef"}

    {:ok, %{status_code: 200, body: Poison.encode!(body)}}
  end
end
