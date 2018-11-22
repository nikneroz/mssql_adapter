Logger.configure(level: :info)
ExUnit.start
ExUnit.configure exclude: [:array_type]

# Configure Ecto for support and tests
Application.put_env(:ecto, :primary_key_type, :id)
Application.put_env(:ecto, :async_integration_tests, true)
Application.put_env(:ecto_sql, :lock_for_update, "FOR UPDATE")

# Configure MSSQL_UID connection
Application.put_env(:ecto_sql, :ms_test_conn,
  adapter: Ecto.Adapters.MSSQL,
  hostname: System.get_env("MSSQL_HST") || "192.168.1.50",
  username: System.get_env("MSSQL_UID") || "sa",
  password: System.get_env("MSSQL_PWD") || "sa_5ecretpa$$",
  migration_lock: "",
  # adapter: Ecto.Adapters.Postgres,
  # hostname: "192.168.1.50",
  # username: "deploy",
  # password: "deploy",
  database: "ecto_test",
  pool: Ecto.Adapters.SQL.Sandbox
)

conn_opts = Application.get_env(:ecto_sql, :ms_test_conn)

# Load support files
ecto = Mix.Project.deps_paths[:ecto]
Code.require_file "#{ecto}/integration_test/support/schemas.exs", __DIR__
Code.require_file "../support/repo.exs", __DIR__
Code.require_file "../support/migration.exs", __DIR__

# Pool repo for async, safe tests
alias Ecto.Integration.TestRepo

Application.put_env(:ecto_sql, TestRepo,
  hostname: conn_opts[:hostname],
  username: conn_opts[:username],
  password: conn_opts[:password],
  database: conn_opts[:database],
  migration_lock: conn_opts[:migration_lock],
  pool: Ecto.Adapters.SQL.Sandbox)

defmodule Ecto.Integration.TestRepo do
  use Ecto.Integration.Repo, otp_app: :ecto_sql, adapter: conn_opts[:adapter] 
end

# Pool repo for non-async tests
alias Ecto.Integration.PoolRepo

Application.put_env(:ecto_sql, PoolRepo,
  hostname: conn_opts[:hostname],
  username: conn_opts[:username],
  password: conn_opts[:password],
  database: conn_opts[:database],
  migration_lock: conn_opts[:migration_lock],
  pool_size: 10,
  max_restarts: 20,
  max_seconds: 10)

defmodule Ecto.Integration.PoolRepo do
  use Ecto.Integration.Repo, otp_app: :ecto_sql, adapter: conn_opts[:adapter]

  def tmp_path do
    Path.expand("../../tmp", __DIR__)
  end

  def create_prefix(prefix) do
    "create schema #{prefix}"
  end

  def drop_prefix(prefix) do
    "drop schema #{prefix}"
  end
end

defmodule Ecto.Integration.Case do
  use ExUnit.CaseTemplate

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(TestRepo)
  end
end

{:ok, _} = Ecto.Adapters.Postgres.ensure_all_started(TestRepo.config(), :temporary)

# Load up the repository, start it, and run migrations

_   = conn_opts[:adapter].storage_down(TestRepo.config())
:ok = conn_opts[:adapter].storage_up(TestRepo.config())

{:ok, _pid} = TestRepo.start_link
{:ok, _pid} = PoolRepo.start_link

%{rows: [[version]]} = TestRepo.query!("SELECT @@version", [])

version =
  case Regex.named_captures(~r/- (?<major>[0-9]+)(\.(?<minor>[0-9]+))?.*/, version) do
    %{"major" => major, "minor" => minor} -> "#{major}.#{minor}.0"
    %{"major" => major} -> "#{major}.0.0"
    _other -> version
  end


if not Version.match?(version, ">= 14.0.0") do
  raise "Only Microsoft SQL Server 2017 14.0.3045.24 was tested. Be careful =)"
end

:ok = Ecto.Migrator.up(TestRepo, 0, Ecto.Integration.Migration, log: false)
Ecto.Adapters.SQL.Sandbox.mode(TestRepo, :manual)
Process.flag(:trap_exit, true)
