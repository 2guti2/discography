defmodule Discography.Albums.Context do
  alias Discography.Albums.BoardList

  def sort(albums) do
    albums
    |> Enum.sort_by(&get_name/1, :asc)
    |> Enum.sort_by(&get_year/1, :asc)
  end

  def split_by_decade(albums) do

  end

  defp get_name(album), do: album.name

  defp get_year(album), do: album.year
end
