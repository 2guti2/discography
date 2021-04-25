defmodule Discography.Integrations.SpotifyServer do
  use GenServer
  alias Discography.Integrations.Spotify

  def start(_, _) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

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
    {:reply, Spotify.get_image(type, name, state.token), state}
  end

  @impl true
  def handle_info(:renew_token, state) do
    schedule_token_renew()

    {
      :noreply,
      state
      |> Map.merge(%{
        token: Spotify.auth_token()
      })
    }
  end

  defp schedule_token_renew do
    Process.send_after(self(), :renew_token, 3600 * 1000)
  end
end
