defmodule Discography.Albums.Album do
  @moduledoc """
  Representation of an album in a non-persisted data structure.

  The following fields are public:
  - `year` - year the album was released
  - `name` - name of the album
  """

  use Ecto.Schema
  import Ecto.Changeset

  @this_year DateTime.utc_now().year
  @type album :: %Discography.Albums.Album{}

  @primary_key false
  embedded_schema do
    field(:year, :integer)
    field(:name, :string)
    field(:cover_url, :string)
  end

  @doc """
    Casts and validates fields for `Discography.Albums.Album`
  """
  def changeset(album, params \\ %{}) do
    album
    |> cast(params, [:year, :name])
    |> validate_required([:year, :name])
    |> validate_inclusion(:year, 1800..@this_year)
  end

  @doc """
  Transforms a year into a decade identifier.
  """
  @spec decade_name(album()) :: String.t()
  def decade_name(album) do
    album.year
    |> Integer.to_string()
    |> String.slice(2..-2)
    |> (&"#{&1}0's").()
  end
end
