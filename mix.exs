defmodule MssqlAdapter.MixProject do
  use Mix.Project

  def project do
    [
      app: :mssql_adapter,
      version: "0.1.1",
      description: "Ecto v3 Adapter to Microsoft SQL Server.",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
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
      {:ecto_sql, "~> 3.0"},
      {:mssqlex_v3, "~> 3.0.0"},
      {:excoveralls, "~> 0.10", only: :test},
      {:inch_ex, github: "rrrene/inch_ex", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    [
      name: :mssql_adapter,
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Denis Rozenkin"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/nikneroz/mssql_adapter"}
    ]
  end
end
