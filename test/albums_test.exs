defmodule Discography.Test.AlbumsTest do
  use ExUnit.Case
  alias Discography.Albums.Album
  alias Discography.Albums
  alias Discography.Albums.Decade

  describe "albums context" do
    test "sort/1 sorts correctly by year and alphabetically" do
      albums = [
        %Album{year: 1975, name: "The Basement Tapes"},
        %Album{year: 1974, name: "Planet Waves"},
        %Album{year: 1976, name: "Desire"},
        %Album{year: 1975, name: "Blood on the Tracks"}
      ]

      expected = [
        %Album{year: 1974, name: "Planet Waves"},
        %Album{year: 1975, name: "Blood on the Tracks"},
        %Album{year: 1975, name: "The Basement Tapes"},
        %Album{year: 1976, name: "Desire"}
      ]

      assert expected == Albums.sort(albums, :asc)
    end
  end

  test "split_by_decade/1 splits correctly" do
    albums = [
      %Album{year: 1975, name: "The Basement Tapes"},
      %Album{year: 2001, name: "2001 Love and Theft"},
      %Album{year: 1974, name: "Planet Waves"},
      %Album{year: 1983, name: "Infidels"}
    ]

    expected = [
      %Decade{
        title: "70's",
        albums: [
          %Album{year: 1975, name: "The Basement Tapes"},
          %Album{year: 1974, name: "Planet Waves"}
        ]
      },
      %Decade{
        title: "80's",
        albums: [
          %Album{year: 1983, name: "Infidels"}
        ]
      },
      %Decade{
        title: "00's",
        albums: [
          %Album{year: 2001, name: "2001 Love and Theft"}
        ]
      }
    ]

    assert expected == Albums.sort(albums, :desc) |> Albums.split_by_decade()
  end
end
