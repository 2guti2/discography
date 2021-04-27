defmodule Discography.Integrations.Trello do
  @moduledoc false

  alias Discography.Integrations.Trello.API
  alias Discography.Albums.Album
  alias Discography.Albums.Decade

  @type album_list :: [%Album{year: integer(), name: String.t()}]
  @type decade_list :: [%Decade{title: String.t(), albums: album_list()}]

  @spec create_lists(decade_list(), String.t()) :: any()
  def create_lists(decades, board_url) do
    board_id = API.get_board_id(board_url)
    for decade <- decades do
      id = API.create_list(board_id, decade.title)
      Map.merge(decade, %{id: id})
    end
  end
end
