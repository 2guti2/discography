defmodule Discography do
  @moduledoc """
  Documentation for `Discography`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Discography.hello()
      :world

  """
  def hello do
    :world
  end

  # mock File https://stackoverflow.com/questions/46936479/mock-function-elixir
  def run(file \\ "discography.txt") do
    file
    |> File.stream!()
    |> Parser.parse
  end
end
