defmodule Discography.Albums.Album do
  @moduledoc """
  Representation of an album in a non-persisted data structure.

  The following fields are public:
  - `year` - year the album was released
  - `name` - name of the album
  """
  @moduledoc section: :albums

  use Ecto.Schema
  import Ecto.Changeset

  @this_year DateTime.utc_now().year

  @primary_key false
  embedded_schema do
    field(:year, :integer)
    field(:name, :string)
  end

  @doc """
    Casts and validates fields for `Discography.Albums.Album`
  """
  def changeset(disc, params \\ %{}) do
    disc
    |> cast(params, [:year, :name])
    |> validate_required([:year, :name])
    |> validate_inclusion(:year, 1800..@this_year)
  end
end
