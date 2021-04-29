defmodule Discography.Test.DiscographyTest do
  use ExUnit.Case

  describe "discography" do
    test "runs correctly" do
      assert {:ok} == Discography.run("some-board-url")
    end

    test "handles bad request and keeps going" do
      assert {:ok} == Discography.run("some-board-url", "some artist", "testbreaker.txt")
    end

    test "handles server error and keeps going" do
      assert {:ok} == Discography.run("some-board-url", "some artist", "serverbreaker.txt")
    end
  end
end
