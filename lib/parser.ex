defmodule Discography.Parser do
  @moduledoc """
  Module that handles the parsing of a text file stream into business structures.
  """

  require Logger
  alias Discography.Albums.Album

  @type stream :: %IO.Stream{}

  @doc """
  Parses a `IO.Stream` of lines that correspond to a year and name of a disc into
  a list of `Discography.Albums.Album`.
  """
  @spec parse(stream()) :: [%Album{year: integer(), name: String.t()}]
  def parse(stream) do
    if Mix.env() == :dev, do: IO.puts("parsing file")

    stream
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_line/1)
    |> filter_out_nils
  end

  defp parse_line(line) do
    {str_year, name} =
      line
      |> String.split(" ", trim: true)
      |> first_and_rest

    case Integer.parse(str_year) do
      {year, ""} ->
        build_album(year, name)

      _ ->
        Logger.error("Invalid year %Album{year: #{str_year}, name: #{name}}")
        nil
    end
  end

  defp build_album(year, name) do
    changeset = Album.changeset(%Album{}, %{year: year, name: name})

    if changeset.valid? do
      %Album{year: year, name: name}
    else
      Logger.error("Album failed validation %Album{year: #{year}, name: #{name}}")
      nil
    end
  end

  defp filter_out_nils(list) do
    list |> Enum.filter(&(!is_nil(&1)))
  end

  defp first_and_rest([h | t]) do
    {h, t |> Enum.join(" ")}
  end
end
