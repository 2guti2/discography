defmodule Discography do
  @moduledoc """
  Entry point of the application.
  """

  alias Discography.Parser
  alias Discography.Albums.Context

  @file_reader Application.compile_env(:discography, :file_reader, File)

  @doc """
  Run utility

  ## Examples

      iex> Discography.run

  """

  @spec run(String.t()) :: any()
  def run(file \\ "discography.txt") do
    file
    |> @file_reader.stream!()
    |> Parser.parse()
    |> Context.sort()
    |> Context.split_by_decade()
  end
end
