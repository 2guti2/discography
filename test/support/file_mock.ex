defmodule Discography.Helpers.FileMock do
  @moduledoc """
  Documentation for `FileMock`.
  """

  alias Discography.Helpers.Streams

  def stream!("discography.txt") do
    Streams.build_stream("1974 Planet Waves\n1975 Blood on the Tracks")
  end
end
