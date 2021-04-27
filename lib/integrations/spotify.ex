defmodule Discography.Integrations.Spotify do
  @moduledoc false

  alias Discography.Integrations.Spotify.API
  alias Discography.Albums.Album

  @type album_list :: [%Album{year: integer(), name: String.t()}]

  @doc """
  Uses `Discography.Integrations.Spotify.API` to add a cover url to each album concurrently.
  """
  @spec add_cover(album_list()) :: album_list()
  def add_cover(albums) do
    auth_token = API.auth_token()

    pmap(albums, fn album ->
      cover_url = API.get_image(auth_token, "album", album.name)
      album |> Map.merge(%{cover_url: cover_url})
    end)
  end

  defp pmap(collection, func) do
    collection
    |> Enum.map(&Task.async(fn -> func.(&1) end))
    |> Enum.map(&Task.await/1)
  end
end
