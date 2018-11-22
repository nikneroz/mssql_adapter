defmodule MssqlAdapter.MixProject do
  use Mix.Project

  def project do
    [
      app: :mssql_adapter,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      test_paths: ["integration_test/mssql", "test"],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "test.integration": :test
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:ecto_sql, "~> 3.0"},
      # {:postgrex, "~> 0.14.0"},
      # {:postgrex, path: "/Users/rozenkin/Projects/postgrex", override: true},
      {:mssqlex, path: "/Users/rozenkin/Projects/mssqlex", override: true},
      {:excoveralls, "~> 0.10", only: :test},
      {:inch_ex, github: "rrrene/inch_ex", only: [:dev, :test]}
    ]
  end
end
