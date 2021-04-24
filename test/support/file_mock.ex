defmodule Discography.Helpers.FileMock do
  @moduledoc """
  Documentation for `FileMock`.
  """

  def stream!("discography.txt") do
    Discography.Helpers.Streams.build_stream("1974 Planet Waves\n1975 Blood on the Tracks")
  end
end
