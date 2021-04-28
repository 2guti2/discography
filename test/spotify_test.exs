defmodule Discography.Test.SpotifyTest do
  use ExUnit.Case

  alias Discography.Integrations.Spotify
  alias Discography.Albums.Album

  describe "spotify context" do
    test "add_cover/2 adds cover to albums" do
      albums = [
        %Album{year: 1974, name: "Planet Waves"},
        %Album{year: 1975, name: "Blood on the Tracks"}
      ]

      expected = [
        %Album{year: 1974, name: "Planet Waves", cover_url: "http://someimageurl.com"},
        %Album{year: 1975, name: "Blood on the Tracks", cover_url: "http://someimageurl.com"}
      ]

      assert expected == Spotify.add_cover(albums, "Bob Dylan")
    end

    test "add_cover/2 on bad request" do
      albums = [
        %Album{year: 1974, name: "TestBreaker"},
        %Album{year: 1975, name: "Blood on the Tracks"}
      ]

      expected = [
        %Album{
          year: 1974,
          name: "TestBreaker",
          cover_url: "https://upload.wikimedia.org/wikipedia/commons/3/3c/No-album-art.png"
        },
        %Album{year: 1975, name: "Blood on the Tracks", cover_url: "http://someimageurl.com"}
      ]

      assert expected == Spotify.add_cover(albums, "Bob Dylan")
    end

    test "add_cover/2 on server error" do
      albums = [
        %Album{year: 1974, name: "ServerBreaker"},
        %Album{year: 1975, name: "Blood on the Tracks"}
      ]

      assert_raise RuntimeError, ~r/(.*?)/, fn ->
        Spotify.add_cover(albums, "Bob Dylan")
      end
    end
  end
end
