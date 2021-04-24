defmodule Discography.Test.AlbumsContextTest do
  use ExUnit.Case
  alias Discography.Albums.Album
  alias Discography.Albums.Context
  alias Discography.Albums.DecadeList

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

      assert expected == Context.sort(albums)
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
      %DecadeList{
        title: "70's",
        albums: [
          %Album{year: 1974, name: "Planet Waves"},
          %Album{year: 1975, name: "The Basement Tapes"}
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
          %Album{year: 2001, name: "2001 Love and Theft"}
        ]
      }
    ]

    assert expected == Context.sort(albums) |> Context.split_by_decade()
  end
end
