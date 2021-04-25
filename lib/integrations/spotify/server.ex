defmodule Discography.Integrations.Spotify.Server do
  @moduledoc """
  `GenServer` instance that manages access to `Discography.Integrations.Spotify.API`.
  Its main purpose is to renew the api token every 3600 seconds to avoid slowing down the image query.
  """

  use GenServer
  alias Discography.Integrations.Spotify.API

  @doc """
  Function used by the supervisor to start the `GenServer`
  """
  def start(_, _) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @doc """
  Returns the url of the image representing an artist or album with a given name.
  """
  @spec get_image(String.t(), String.t()) :: String.t()
  def get_image(type, name) do
    GenServer.call(__MODULE__, {:get_image, type, name})
  end

  @impl true
  def init(state) do
    send(self(), :renew_token)

    {:ok, state}
  end

  @impl true
  def handle_call({:get_image, type, name}, _from, state) do
    {:reply, API.get_image(type, name, state.token), state}
  end

  @impl true
  def handle_info(:renew_token, state) do
    schedule_token_renew()

    {
      :noreply,
      state
      |> Map.merge(%{
        token: API.auth_token()
      })
    }
  end

  defp schedule_token_renew do
    Process.send_after(self(), :renew_token, 3600 * 1000)
  end
end
