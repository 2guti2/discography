defmodule Discography.Test.DiscographyTest do
  use ExUnit.Case
  alias Discography.Disc
  import Discography

  describe "discography" do
    test "runs correctly" do
      expected = [
        %Disc{year: 1974, name: "Planet Waves"},
        %Disc{year: 1975, name: "Blood on the Tracks"}
      ]

      assert expected == run()
    end
  end
end
