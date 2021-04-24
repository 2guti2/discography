defmodule Discography do
  @moduledoc """
  Documentation for `Discography`.
  """

  alias Discography.Parser

  @doc """
  Run utility

  ## Examples

      iex> Discography.run

  """
  def run(file \\ "discography.txt") do
    file
    |> File.stream!()
    |> Parser.parse()
  end
end
