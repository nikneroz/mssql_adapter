defmodule MssqlAdapterTest do
  use ExUnit.Case
  doctest MssqlAdapter

  test "greets the world" do
    assert MssqlAdapter.hello() == :world
  end
end
