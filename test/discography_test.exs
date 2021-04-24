defmodule Discography.Test.DiscographyTest do
  use ExUnit.Case
  import Discography
  alias Discography.Albums.Album
  alias Discography.Albums.DecadeList

  describe "discography" do
    test "runs correctly" do
      expected = [
        %DecadeList{
          title: "70's",
          albums: [
            %Album{year: 1973, name: "Pat Garrett & Billy the Kid"}
          ]
        },
        %DecadeList{
          title: "80's",
          albums: [
            %Album{year: 1983, name: "Infidels"}
          ]
        },
        %DecadeList{
          title: "00's",
          albums: [
            %Album{year: 2006, name: "Modern Times"}
          ]
        }
      ]

      assert expected == run()
    end
  end
end
