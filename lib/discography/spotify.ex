defmodule Discography.Integrations.Spotify do
  @moduledoc """
  Spotify API context. Manages access to the API through business-driven functions.
  """

  require Logger
  alias Discography.Integrations.Spotify.API
  alias Discography.Albums.Album

  @type album_list :: [%Album{year: integer(), name: String.t()}]

  @doc """
  Uses `Discography.Integrations.Spotify.API` to add a cover url to each album concurrently.
  """
  @spec add_cover(album_list(), String.t()) :: album_list()
  def add_cover(albums, artist) do
    Logger.info("adding spotify cover")
    auth_token = API.auth_token()

    albums =
      pmap(albums, fn album ->
        cover_url = API.get_image(auth_token, "album", "#{artist} #{album.name}")
        album |> Map.merge(%{cover_url: cover_url})
      end)

    if albums |> any_cover_is_nil?() do
      raise "Error connecting to external API, please check your internet connection"
    else
      albums
    end
  end

  defp any_cover_is_nil?(albums) do
    Enum.any?(albums, fn album -> album.cover_url == nil end)
  end

  defp pmap(collection, func) do
    collection
    |> Enum.map(&Task.async(fn -> func.(&1) end))
    |> Enum.map(&Task.await/1)
  end
end
