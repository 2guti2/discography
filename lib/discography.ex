defmodule Discography do
  @moduledoc """
  Entry point of the application.
  """

  alias Discography.Parser
  alias Discography.Albums
  alias Discography.Integrations.Trello

  @file_reader Application.compile_env(:discography, :file_reader, File)

  @doc """
  Run utility

  ## Examples

      iex> Discography.run

  """
  @spec run(String.t()) :: any()
  def run(board_url, file \\ "discography.txt") do
    file
    |> @file_reader.stream!()
    |> Parser.parse()
    |> Albums.add_cover()
    |> Albums.sort()
    |> Albums.split_by_decade()
    |> Trello.create_lists(board_url)
  end
end
