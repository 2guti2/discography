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
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.12", only: :test},
      {:ecto_sql, "~> 3.4"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false}
    ]
  end
end
