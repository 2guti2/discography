defmodule Discography.Integrations.Trello do
  @moduledoc """
  Trello API context. Manages access to the API through business-driven functions.
  """

  require Logger
  alias Discography.Integrations.Trello.API
  alias Discography.Albums.Album
  alias Discography.Albums.Decade

  @type album_list :: [%Album{year: integer(), name: String.t()}]
  @type decade_list :: [%Decade{title: String.t(), albums: album_list()}]

  @spec overwrite_lists(decade_list(), String.t()) :: decade_list()
  def overwrite_lists(decades, board_url) do
    Logger.info("archiving preexisting lists on board")

    board_id = API.get_board_id(board_url)
    archive_preexisting_lists(board_id)

    Logger.info("creating new lists")

    for decade <- decades do
      id = API.create_list(board_id, decade.title)
      Map.merge(decade, %{id: id})
    end
  end

  @spec add_cards_to_lists(decade_list()) :: tuple()
  def add_cards_to_lists(decades) do
    Logger.info("adding albums to lists")

    for decade <- decades, album <- decade.albums do
      card_title = "#{album.year} - #{album.name}"
      Logger.info("creating card #{card_title}")
      API.create_card(decade.id, card_title, album.cover_url)
    end

    {:ok}
  end

  defp archive_preexisting_lists(board_id) do
    board_id
    |> API.get_lists()
    |> API.archive_lists()
  end
end
