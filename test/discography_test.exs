defmodule Discography.Test.DiscographyTest do
  use ExUnit.Case
  alias Discography.Album
  import Discography

  describe "discography" do
    test "runs correctly" do
      expected = [
        %Album{year: 1974, name: "Planet Waves"},
        %Album{year: 1975, name: "Blood on the Tracks"}
      ]

      assert expected == run()
    end
  end
end
