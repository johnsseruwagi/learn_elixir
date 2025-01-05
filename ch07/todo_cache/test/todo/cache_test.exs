defmodule Todo.CacheTest do
  use ExUnit.Case

  test "server_process" do
    {:ok, cache} = Todo.Cache.start()

    natalie_pid = Todo.Cache.server_process(cache, "natalie")

    assert natalie_pid != Todo.Cache.server_process(cache, "mary")
    assert natalie_pid == Todo.Cache.server_process(cache, "natalie")
  end

  test "to-do operations" do
    {:ok, cache} = Todo.Cache.start()

    mary = Todo.Cache.server_process(cache, "mary")
    Todo.Server.add_entry(mary, %{date: ~D[2025-01-05], title: "Testing"})

    entries = Todo.Server.entries(mary, ~D[2025-01-05])

    assert [%{date: ~D[2025-01-05], title: "Testing", id: 1}] == entries
  end
end
