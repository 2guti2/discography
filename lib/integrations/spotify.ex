defmodule Discography.Integrations.Spotify do
  @client_id System.get_env("SPOTIFY_CLIENT_ID")
  @client_secret System.get_env("SPOTIFY_CLIENT_SECRET")

  def run() do
    get_image("album", "Blood on the Tracks", auth_token())
  end

  # ref https://developer.spotify.com/console/get-search-item/
  def get_image(type, name, token) do
    res =
      HTTPoison.get(
        "https://api.spotify.com/v1/search?type=#{type}&q=#{normalize_query(name)}",
        Authorization: token
      )

    case res do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode!(body)["#{type}s"]["items"]
        |> Enum.at(0)
        |> (& &1["images"]).()
        |> Enum.at(0)
        |> (& &1["url"]).()

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.inspect("Not found :(")

      {:ok, %HTTPoison.Response{status_code: 400} = q} ->
        IO.inspect("Bad Request")
        IO.inspect(q)

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  defp normalize_query(str), do: str |> String.replace(" ", "%20")

  # https://developer.spotify.com/documentation/general/guides/authorization-guide/#client-credentials-flow
  def auth_token() do
    res =
      HTTPoison.post(
        "https://accounts.spotify.com/api/token",
        URI.encode_query(%{"grant_type" => "client_credentials"}),
        %{
          "Content-Type" => "application/x-www-form-urlencoded",
          "Authorization" => "Basic #{Base.encode64("#{@client_id}:#{@client_secret}")}"
        }
      )

    case res do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        "Bearer #{Poison.decode!(body)["access_token"]}"

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.inspect("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
