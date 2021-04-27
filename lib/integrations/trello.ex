defmodule Discography.Integrations.Trello do
  @moduledoc false

  alias Discography.Integrations.Trello.API
  alias Discography.Albums.Album
  alias Discography.Albums.Decade
  alias Discography.Albums.Board

  @type album_list :: [%Album{year: integer(), name: String.t()}]
  @type decade_list :: [%Decade{title: String.t(), albums: album_list()}]

  @spec overwrite_lists(decade_list(), String.t()) :: any()
  def overwrite_lists(decades, board_url) do
    IO.puts("archiving preexisting lists on board")

    board_id = API.get_board_id(board_url)
    archive_preexisting_lists(board_id)

    IO.puts("creating new lists")

    decades =
      for decade <- decades do
        id = API.create_list(board_id, decade.title)
        Map.merge(decade, %{id: id})
      end

    %Board{id: board_id, decades: decades}
  end

  defp archive_preexisting_lists(board_id) do
    board_id
    |> API.get_lists()
    |> API.archive_lists()
  end

  def add_cards_to_lists(board) do
    IO.puts("adding albums to lists")
    board
  end
end
