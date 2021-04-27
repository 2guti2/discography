defmodule Discography.Test.DiscographyTest do
  use ExUnit.Case
  import Discography
  alias Discography.Albums.Album
  alias Discography.Albums.Decade

  describe "discography" do
    test "runs correctly" do
      expected = [
        %Decade{
          title: "70's",
          albums: [
            %Album{
              year: 1973,
              name: "Pat Garrett & Billy the Kid",
              cover_url: "http://someimageurl.com"
            }
          ]
        },
        %Decade{
          title: "80's",
          albums: [
            %Album{
              year: 1983,
              name: "Infidels",
              cover_url: "http://someimageurl.com"
            }
          ]
        },
        %Decade{
          title: "00's",
          albums: [
            %Album{
              year: 2006,
              name: "Modern Times",
              cover_url: "http://someimageurl.com"
            }
          ]
        }
      ]

      # assert expected == run()
    end

    test "handles bad request and keeps going" do
      expected = [
        %Decade{
          title: "70's",
          albums: [
            %Album{
              year: 1973,
              name: "TestBreaker",
              cover_url: "https://upload.wikimedia.org/wikipedia/commons/3/3c/No-album-art.png"
            }
          ]
        }
      ]

      # assert expected == run("testbreaker.txt")
    end

    test "handles server error and keeps going" do
      expected = [
        %Decade{
          title: "70's",
          albums: [
            %Album{
              year: 1973,
              name: "ServerBreaker",
              cover_url: "https://upload.wikimedia.org/wikipedia/commons/3/3c/No-album-art.png"
            }
          ]
        }
      ]

      # assert expected == run("serverbreaker.txt")
    end
  end
end
