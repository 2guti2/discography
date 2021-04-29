defmodule Discography.Http do
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
