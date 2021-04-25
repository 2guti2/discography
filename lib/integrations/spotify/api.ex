defmodule Discography.Integrations.Spotify.API do
  @moduledoc """
  Spotify API access module.
  """

  @client_id System.get_env("SPOTIFY_CLIENT_ID")
  @client_secret System.get_env("SPOTIFY_CLIENT_SECRET")
  @default_cover_url "https://upload.wikimedia.org/wikipedia/commons/3/3c/No-album-art.png"

  @doc """
    Returns the url of the image representing an artist or album with a given name
    using the following endpoint:
    https://developer.spotify.com/console/get-search-item/
  """
  @spec get_image(String.t(), String.t(), String.t()) :: String.t()
  def get_image(token, type, name) do
    HTTPoison.get(
      "https://api.spotify.com/v1/search?type=#{type}&q=#{normalize_query(name)}",
      Authorization: token
    )
    |> handle_response(fn result ->
      case result do
        {:ok, body} ->
          Poison.decode!(body)["#{type}s"]["items"]
          |> Enum.at(0)
          |> get_image_url_from_response()

        {:error, _} ->
          @default_cover_url
      end
    end)
  end

  defp get_image_url_from_response(resp) when resp != nil do
    resp
    |> (& &1["images"]).()
    |> Enum.at(0)
    |> (& &1["url"]).()
  end

  defp get_image_url_from_response(resp) when resp == nil do
    @default_cover_url
  end

  defp normalize_query(str), do: str |> String.replace(" ", "%20")

  @doc """
    Returns a Spotify auth token using the process expressed here:
    https://developer.spotify.com/documentation/general/guides/authorization-guide/#client-credentials-flow
  """
  @spec auth_token() :: String.t()
  def auth_token() do
    HTTPoison.post(
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

  defp handle_response(res, callback) do
    case res do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        callback.({:ok, body})

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        callback.({:error, nil})

      {:ok, %HTTPoison.Response{status_code: 400}} ->
        callback.({:error, nil})

      {:error, %HTTPoison.Error{reason: _reason}} ->
        callback.({:error, nil})
    end
  end
end
