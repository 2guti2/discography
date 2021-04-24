defmodule Discography.Albums.BoardList do
  defstruct [:title , :albums, :decade_id]

  def decade_name(year) do
    year
    |> Integer.to_string()
    |> String.slice(2..-2)
    |> (&"#{&1}0's").()
  end
end
