# MssqlAdapter

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `mssql_adapter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mssql_adapter, "~> 0.1.0"}
  ]
end
```

## Docker 

```bash
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=sa_5ecretpa$$' -p 1433:1433 -d microsoft/mssql-server-linux:2017-latest
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/mssql_adapter](https://hexdocs.pm/mssql_adapter).

