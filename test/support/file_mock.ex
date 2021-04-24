defmodule Discography.Support.FileMock do
  @moduledoc """
  Documentation for `FileMock`.
  """

  alias Discography.Support.Streams

  def stream!("discography.txt") do
    Streams.build_stream("1973 Pat Garrett & Billy the Kid\n1983 Infidels\n2006 Modern Times")
  end
end
