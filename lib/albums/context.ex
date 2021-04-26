defmodule Discography.Albums.Context do
  @moduledoc """
  Isolate access to `Discography.Albums.Album` and `Discography.Albums.Decade`.
  """

  alias Discography.Albums.Album
  alias Discography.Albums.Decade
  alias Discography.Integrations.Spotify.API

  @type album_list :: [%Album{year: integer(), name: String.t()}]
  @type decade_list_list :: [%Decade{title: String.t(), albums: album_list()}]

  @doc """
  Sort albums by year and if they have the same one, alphabetically.
  """
  @spec sort(album_list()) :: album_list()
  def sort(albums) do
    albums
    |> Enum.sort_by(&get_name/1, :asc)
    |> Enum.sort_by(&get_year/1, :asc)
  end

  @doc """
  Create a `Discography.Albums.Decade` list of the albums.
  """
  @spec split_by_decade(album_list()) :: decade_list_list()
  def split_by_decade(albums) do
    albums
    |> Enum.chunk_by(fn album -> Decade.decade_name(album.year) end)
    |> build_decade_lists()
  end

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

  defp build_decade_lists(album_lists) do
    for list <- album_lists do
      %Decade{
        title: Enum.at(list, 0).year |> Decade.decade_name(),
        albums: list
      }
    end
  end

  defp get_name(album), do: album.name

  defp get_year(album), do: album.year
end
