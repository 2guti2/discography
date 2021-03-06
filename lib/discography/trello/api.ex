defmodule Discography.Integrations.Trello.API do
  @moduledoc """
  Trello API access module.
  """

  import Discography.Http
  @api_key System.get_env("TRELLO_API_KEY")
  @token System.get_env("TRELLO_TOKEN")
  @http_client Application.compile_env(:discography, :http_client, HTTPoison)
  @base_url "https://api.trello.com/1"

  def get_board_id(url) do
    URI.encode_query(%{
      "key" => @api_key,
      "token" => @token
    })
    |> (&".json?#{&1}").()
    |> (&@http_client.get("#{remove_last_slash(url)}#{&1}")).()
    |> handle_response(fn result ->
      case result do
        {:ok, body} ->
          Poison.decode!(body)["id"]

        {:error, _} ->
          nil
      end
    end)
  end

  def get_lists(board_id) do
    query =
      URI.encode_query(%{
        "key" => @api_key,
        "token" => @token
      })

    @http_client.get("#{@base_url}/boards/#{board_id}/lists?#{query}")
    |> handle_response(fn result ->
      case result do
        {:ok, body} -> Poison.decode!(body)
        {:error, _} -> nil
      end
    end)
  end

  def archive_lists(lists) do
    query =
      URI.encode_query(%{
        "key" => @api_key,
        "token" => @token,
        "closed" => true
      })

    for list <- lists do
      @http_client.put("#{@base_url}/lists/#{list["id"]}?#{query}")
    end
  end

  def create_list(board_id, list_name) do
    query =
      URI.encode_query(%{
        "key" => @api_key,
        "token" => @token,
        "name" => list_name,
        "idBoard" => board_id
      })

    @http_client.post("#{@base_url}/lists?#{query}", [])
    |> handle_response(fn result ->
      case result do
        {:ok, body} ->
          Poison.decode!(body)["id"]

        {:error, _} ->
          nil
      end
    end)
  end

  def create_card(list_id, card_name, cover_url) do
    query =
      URI.encode_query(%{
        "key" => @api_key,
        "token" => @token,
        "name" => card_name,
        "idList" => list_id,
        "urlSource" => cover_url
      })

    @http_client.post("#{@base_url}/cards?#{query}", [])
    |> handle_response(fn result ->
      case result do
        {:ok, _body} ->
          {:ok}

        {:error, _} ->
          {:error}
      end
    end)
  end

  defp remove_last_slash(url) do
    last = String.last(url)

    if last == "/" do
      String.slice(url, 0..(String.length(url) - 2))
    else
      url
    end
  end
end
