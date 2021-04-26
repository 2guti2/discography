defmodule Discography.Support.FileMock do
  @moduledoc false

  alias Discography.Support.Streams

  def stream!("discography.txt") do
    Streams.build_stream("1973 Pat Garrett & Billy the Kid\n1983 Infidels\n2006 Modern Times")
  end

  def stream!("testbreaker.txt") do
    Streams.build_stream("1973 TestBreaker")
  end

  def stream!("serverbreaker.txt") do
    Streams.build_stream("1973 ServerBreaker")
  end
end
