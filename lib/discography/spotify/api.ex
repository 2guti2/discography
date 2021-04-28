defmodule Discography.Integrations.Spotify.API do
  @moduledoc """
  Spotify API access module.
  """

  @client_id System.get_env("SPOTIFY_CLIENT_ID")
  @client_secret System.get_env("SPOTIFY_CLIENT_SECRET")
  @default_cover_url "https://upload.wikimedia.org/wikipedia/commons/3/3c/No-album-art.png"
  @http_client Application.compile_env(:discography, :http_client, HTTPoison)

  @doc """
    Returns the url of the image representing an artist or album with a given name
    using the following endpoint:
    https://developer.spotify.com/console/get-search-item/
  """
  @spec get_image(String.t(), String.t(), String.t()) :: String.t()
  def get_image(token, type, name) do
    name = name |> String.replace("'", "") |> String.replace("’", "")

    @http_client.get(
      "https://api.spotify.com/v1/search?type=#{type}&q=#{normalize_query(name)}",
      Authorization: token
    )
    |> handle_response(fn result ->
      case result do
        {:ok, body} ->
          Poison.decode!(body)
          |> get_image_url_from_response(type)

        {:error, _} ->
          @default_cover_url
      end
    end)
  end

  @doc """
    Returns a Spotify auth token using the process expressed here:
    https://developer.spotify.com/documentation/general/guides/authorization-guide/#client-credentials-flow
  """
  @spec auth_token() :: String.t()
  def auth_token() do
    @http_client.post(
      "https://accounts.spotify.com/api/token",
      URI.encode_query(%{"grant_type" => "client_credentials"}),
      %{
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Basic #{Base.encode64("#{@client_id}:#{@client_secret}")}"
      }
    )
    |> handle_response(fn result ->
      case result do
        {:ok, body} ->
          "Bearer #{Poison.decode!(body)["access_token"]}"

        {:error, _} ->
          ""
      end
    end)
  end

  defp get_image_url_from_response(resp, type) do
    item =
      resp["#{type}s"]["items"]
      |> Enum.at(0)

    if item == nil do
      @default_cover_url
    else
      item
      |> (& &1["images"]).()
      |> Enum.at(0)
      |> (& &1["url"]).()
    end
  end

  defp normalize_query(str), do: str |> String.replace(" ", "%20")

  defp handle_response(res, callback) do
    case res do
      {:ok, %{status_code: 200, body: body}} ->
        callback.({:ok, body})

      {:ok, %{status_code: 400}} ->
        callback.({:error, nil})

      {:error, %{reason: _reason}} ->
        callback.({:error, nil})
    end
  end
end
