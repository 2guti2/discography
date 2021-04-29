defmodule Discography.Test.TrelloTest do
  use ExUnit.Case

  alias Discography.Albums.Decade
  alias Discography.Albums.Album
  alias Discography.Integrations.Trello

  describe "trello" do
    test "add_cards_to_lists/1 adds cards to lists" do
      decades = [
        %Decade{
          title: "70's",
          albums: [
            %Album{year: 1975, name: "The Basement Tapes"},
            %Album{year: 1974, name: "Planet Waves"}
          ]
        }
      ]

      assert :ok == Trello.add_cards_to_lists(decades)
    end

    test "add_cards_to_lists/1 adds cards to lists on error" do
      decades = [
        %Decade{
          title: "70's",
          albums: [
            %Album{year: 1975, name: "The Basement Tapes"},
            %Album{year: 1974, name: "Error"}
          ]
        }
      ]

      assert :ok == Trello.add_cards_to_lists(decades)
    end

    test "overwrite_lists/2 works" do
      decades = [
        %Decade{
          title: "70's",
          albums: [
            %Album{year: 1975, name: "The Basement Tapes"},
            %Album{year: 1974, name: "Planet Waves"}
          ]
        }
      ]

      expected = [
        %Decade{
          id: "an-id",
          title: "70's",
          albums: [
            %Album{year: 1975, name: "The Basement Tapes"},
            %Album{year: 1974, name: "Planet Waves"}
          ]
        }
      ]

      assert expected == Trello.overwrite_lists(decades, "some-board-url")
    end

    test "overwrite_lists/2 works with slash at the end" do
      decades = [
        %Decade{
          title: "70's",
          albums: [
            %Album{year: 1975, name: "The Basement Tapes"},
            %Album{year: 1974, name: "Planet Waves"}
          ]
        }
      ]

      expected = [
        %Decade{
          id: "an-id",
          title: "70's",
          albums: [
            %Album{year: 1975, name: "The Basement Tapes"},
            %Album{year: 1974, name: "Planet Waves"}
          ]
        }
      ]

      assert expected == Trello.overwrite_lists(decades, "some-board-url/")
    end
  end
end
