defmodule Discography.Support.Streams do
  @moduledoc false

  def build_stream(file_content) do
    {:ok, stream} = file_content |> StringIO.open()
    stream |> IO.binstream(:line)
  end
end
