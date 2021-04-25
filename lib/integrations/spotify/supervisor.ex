defmodule Discography.Integrations.Spotify.Supervisor do
  @moduledoc false

  use Supervisor
  alias Discography.Integrations.Spotify.Server

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_opts) do
    children = [
      Server
    ]

    Supervisor.start_link(children, strategy: :one_for_all)
  end
end
