defmodule Discography.MixProject do
  use Mix.Project

  def project do
    [
      app: :discography,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      docs: [
        groups_for_modules: [
          Main: [Discography],
          Parser: [Discography.Parser],
          Albums: [
            Discography.Albums.Context,
            Discography.Albums.Album,
            Discography.Albums.DecadeList
          ],
          "Spotify Integration": [
            Discography.Integrations.Spotify.Server,
            Discography.Integrations.Spotify.API
          ]
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Discography.Integrations.Spotify.Server, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.12", only: :test},
      {:ecto, "~> 3.4"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:httpoison, "~> 1.8"},
      {:poison, "~> 3.1"}
    ]
  end
end
