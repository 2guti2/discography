defmodule Disc do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:year, :integer)
    field(:name, :string)
  end

  def changeset(disc, params \\ %{}) do
    disc
    |> cast(params, [:year, :name])
    |> validate_required([:year, :name])
    |> validate_inclusion(:year, 1800..DateTime.utc_now().year)
  end
end
