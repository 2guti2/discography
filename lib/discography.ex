defmodule Discography do
  @moduledoc false

  alias Discography.Parser

  @file_reader Application.compile_env(:discography, :file_reader, File)

  @doc """
  Run utility

  ## Examples

      iex> Discography.run

  """

  def run(file \\ "discography.txt") do
    file
    |> @file_reader.stream!()
    |> Parser.parse()
  end
end
