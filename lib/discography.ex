defmodule Discography do
  @moduledoc """
  Entry point of the application.
  """

  alias Discography.Parser
  alias Discography.Albums
  alias Discography.Integrations.Trello
  alias Discography.Integrations.Spotify

  @file_reader Application.compile_env(:discography, :file_reader, File)

  @doc """
  Run utility

  ## Examples

      iex> Discography.run "https://trello.com/b/cSCGNr0r/discography"

  """
  @spec run(String.t()) :: any()
  def run(board_url, artist \\ "Bob Dylan", file \\ "discography.txt") do
    file
    |> @file_reader.stream!()
    |> Parser.parse()
    |> Spotify.add_cover(artist)
    |> Albums.sort()
    |> Albums.split_by_decade()
    |> Trello.overwrite_lists(board_url)
    |> Trello.add_cards_to_lists()
  end
end
