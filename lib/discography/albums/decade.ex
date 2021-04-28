defmodule Discography.Albums.Decade do
  @moduledoc """
  Representation of a list of albums in a decade in a non-persisted data structure.

  The following fields are public:
  - `title` - a title of the decade
  - `albums` - list of `Discography.Albums.Album`
  """

  defstruct [:title, :albums, :id]
end
