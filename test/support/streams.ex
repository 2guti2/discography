defmodule Discography.Helpers.Streams do
  @moduledoc """
  Documentation for `Streams`.
  """

  def build_stream(file_content) do
    {:ok, stream} = file_content |> StringIO.open()
    stream |> IO.binstream(:line)
  end
end
