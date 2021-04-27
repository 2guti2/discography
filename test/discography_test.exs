defmodule Discography.Test.DiscographyTest do
  use ExUnit.Case

  describe "discography" do
    test "runs correctly" do
      #assert {:ok} == Discography.run("some url")
    end

    test "handles bad request and keeps going" do
      #assert {:ok} == Discography.run("some url", "some artist", "testbreaker.txt")
    end

    test "handles server error and keeps going" do
      #assert {:ok} == Discography.run("some url", "some artist", "serverbreaker.txt")
    end
  end
end
