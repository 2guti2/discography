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

  def run(file \\ "discography.txt") do
    file |> Parser.get()
  end
end
