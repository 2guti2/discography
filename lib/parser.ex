defmodule Parser do
  require Logger

  def get(file \\ "discography.txt") do
    file
    |> read
    |> parse
  end

  defp read(file_name) do
    file_name
    |> File.stream!()
    |> Enum.map(&String.trim/1)
  end

  defp parse(lines) do
    lines
    |> Enum.map(&parse_line/1)
    |> filter_out_nils
  end

  defp parse_line(line) do
    {year, name} =
      line
      |> String.split(" ", trim: true)
      |> first_and_rest

    changeset = Disc.changeset(%Disc{}, %{year: year, name: name})

    if changeset.valid? do
      %Disc{year: year, name: name}
    else
      Logger.error("Disc failed validation %Disc{year: #{year}, name: #{name}}")
      nil
    end
  end

  defp filter_out_nils(list) do
    list |> Enum.filter(&(!is_nil(&1)))
  end

  defp first_and_rest([h | t]) do
    {h, t |> Enum.join(" ")}
  end
end
