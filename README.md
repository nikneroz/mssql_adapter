# MssqlAdapter

[![Hex.pm Version](https://img.shields.io/hexpm/v/mssql_adapter.svg)](https://hex.pm/packages/mssql_adapter)
[![Hex.pm Downloads](https://img.shields.io/hexpm/dt/mssql_adapter.svg)](https://hex.pm/packages/mssql_adapter)

## Warning!

This library is not ready! Tests aren't passing and there are no docs!

## Installation

MssqlAdapter requires the [MssqlexV3](https://github.com/nikneroz/mssqlex_v3).

This package is availabe in Hex, the package can be installed
by adding `mssqlex_v3` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:mssql_adapter, "~> 0.1.0"}]
end
```

## Docker 

```bash
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=sa_5ecretpa$$' -p 1433:1433 -d microsoft/mssql-server-linux:2017-latest
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/mssql_adapter](https://hexdocs.pm/mssql_adapter).

