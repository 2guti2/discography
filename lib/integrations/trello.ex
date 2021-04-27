defmodule Discography.Integrations.Trello do
  @moduledoc false

  alias Discography.Integrations.Trello.API
  alias Discography.Albums.Album
  alias Discography.Albums.Decade

  @type album_list :: [%Album{year: integer(), name: String.t()}]
  @type decade_list :: [%Decade{title: String.t(), albums: album_list()}]

  @spec overwrite_lists(decade_list(), String.t()) :: any()
  def overwrite_lists(decades, board_url) do
    if Mix.env() == :dev, do: IO.puts("archiving preexisting lists on board")

    board_id = API.get_board_id(board_url)
    archive_preexisting_lists(board_id)

    if Mix.env() == :dev, do: IO.puts("creating new lists")

    for decade <- decades do
      id = API.create_list(board_id, decade.title)
      Map.merge(decade, %{id: id})
    end
  end

  defp archive_preexisting_lists(board_id) do
    board_id
    |> API.get_lists()
    |> API.archive_lists()
  end

  def add_cards_to_lists(decades) do
    if Mix.env() == :dev, do: IO.puts("adding albums to lists")

    for decade <- decades do
      for album <- decade.albums do
        card_title = "#{album.year} - #{album.name}"
        if Mix.env() == :dev, do: IO.puts("creating card #{card_title}")
        API.create_card(decade.id, card_title, album.cover_url)
      end
    end

    {:ok}
  end
end
