defmodule Discography.Http do
  @moduledoc """
  Module that contains HTTP helper functions.
  """

  @doc """
    Handles an HTTPPoisonResponse.
  """
  @spec handle_response(tuple(), (tuple() -> none())) :: none()
  def handle_response(res, callback) do
    case res do
      {:ok, %{status_code: 200, body: body}} ->
        callback.({:ok, body})

      {:ok, %{status_code: 400}} ->
        callback.({:error, nil})

      {:error, %{reason: _reason}} ->
        callback.({:error, "connection"})
    end
  end
end
