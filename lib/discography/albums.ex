defmodule Discography.Albums do
  @moduledoc """
  Isolate access to `Discography.Albums.Album` and `Discography.Albums.Decade`.
  """

  alias Discography.Albums.Album
  alias Discography.Albums.Decade

  @type album_list :: [%Album{year: integer(), name: String.t()}]
  @type decade_list :: [%Decade{title: String.t(), albums: album_list()}]

  @doc """
  Sort albums by year and if they have the same one, alphabetically.
  """
  @spec sort(album_list()) :: album_list()
  def sort(albums, order \\ :asc) do
    if Mix.env() == :dev, do: IO.puts("sorting albums")

    albums
    |> Enum.sort_by(&get_name/1, order)
    |> Enum.sort_by(&get_year/1, order)
  end

  @doc """
  Create a `Discography.Albums.Decade` list of the albums.
  """
  @spec split_by_decade(album_list()) :: decade_list()
  def split_by_decade(albums) do
    if Mix.env() == :dev, do: IO.puts("splitting albums by decade")

    albums
    |> Enum.chunk_by(fn album -> album |> Album.decade_name() end)
    |> build_decades()
    |> Enum.reverse()
  end

  defp build_decades(album_lists) do
    for list <- album_lists do
      %Decade{
        title: list |> Enum.at(0) |> Album.decade_name(),
        albums: list
      }
    end
  end

  defp get_name(album), do: album.name

  defp get_year(album), do: album.year
end
