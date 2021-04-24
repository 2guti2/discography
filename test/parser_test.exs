defmodule ParserTest do
  use ExUnit.Case

  import ExUnit.CaptureLog
  require Logger
  alias Discography.Disc
  alias Discography.Parser

  def build_stream(file_content) do
    {:ok, stream} = file_content |> StringIO.open()
    stream |> IO.binstream(:line)
  end

  describe "parser" do
    test "parses correctly" do
      stream = build_stream("1974 Planet Waves\n1975 Blood on the Tracks")

      expected = [
        %Disc{year: 1974, name: "Planet Waves"},
        %Disc{year: 1975, name: "Blood on the Tracks"}
      ]

      assert expected == Parser.parse(stream)
    end

    test "keeps parsing when year is invalid" do
      stream = build_stream("invalid\n1975 Blood on the Tracks")

      expected = [%Disc{year: 1975, name: "Blood on the Tracks"}]

      assert capture_log(fn ->
               assert expected == Parser.parse(stream)
             end) =~ "Invalid year"
    end

    test "keeps parsing when year is not in range" do
      stream = build_stream("1750 Planet Waves\n1975 Blood on the Tracks")

      expected = [%Disc{year: 1975, name: "Blood on the Tracks"}]

      assert capture_log(fn ->
               assert expected == Parser.parse(stream)
             end) =~ "Disc failed validation %Disc{year: 1750, name: Planet Waves}"
    end
  end
end
