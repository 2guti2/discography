defmodule Discography.Disc do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @this_year DateTime.utc_now().year

  @primary_key false
  embedded_schema do
    field(:year, :integer)
    field(:name, :string)
  end

  def changeset(disc, params \\ %{}) do
    disc
    |> cast(params, [:year, :name])
    |> validate_required([:year, :name])
    |> validate_inclusion(:year, 1800..@this_year)
  end
end
