defmodule Discography.Integrations.SpotifySupervisor do
  use Supervisor
  alias Discography.Integrations.SpotifyServer

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_opts) do
    children = [
      SpotifyServer
    ]

    Supervisor.start_link(children, strategy: :one_for_all)
  end
end
