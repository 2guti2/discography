defmodule Discography.Albums.DecadeList do
  @moduledoc """
  Representation of a list of albums in a decade in a non-persisted data structure.

  The following fields are public:
  - `title` - a title of the decade
  - `albums` - list of `Discography.Albums.Album`
  """

  defstruct [:title, :albums]

  @doc """
  Transforms a year into a decade identifier.
  """
  @spec decade_name(integer()) :: String.t()
  def decade_name(year) do
    year
    |> Integer.to_string()
    |> String.slice(2..-2)
    |> (&"#{&1}0's").()
  end
end
