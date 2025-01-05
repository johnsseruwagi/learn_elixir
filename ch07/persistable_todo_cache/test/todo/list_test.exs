defmodule Todo.ListTest do
  use ExUnit.Case, async: true

  test "to-do empty list" do
    assert Todo.List.size(Todo.List.new()) == 0
  end

  test "to-do add entries" do
    todo_list =
      Todo.List.new()
      |> Todo.List.add_entry(%{date: ~D[2025-01-01], title: "New Year's Day"})
      |> Todo.List.add_entry(%{date: ~D[2025-01-02], title: "Shopping"})
      |> Todo.List.add_entry(%{date: ~D[2025-01-01], title: "Movie Night"})

    assert Todo.List.size(todo_list) == 3
    assert todo_list |> Todo.List.entries(~D[2025-01-01]) |> length() == 2
    assert todo_list |> Todo.List.entries(~D[2025-01-02]) |> length() == 1
    assert todo_list |> Todo.List.entries(~D[2025-01-03]) |> length() == 0

    titles = todo_list |> Todo.List.entries(~D[2025-01-01]) |> Enum.map(& &1.title)

    assert ["New Year's Day", "Movie Night"] == titles
  end

  test "to-do entries" do
    todo_list =
      Todo.List.new([
        %{date: ~D[2025-01-01], title: "New Year's Day"},
        %{date: ~D[2025-01-02], title: "Shopping"},
        %{date: ~D[2025-01-01], title: "Movie Night"}
      ])

    assert Todo.List.size(todo_list) == 3
    assert todo_list |> Todo.List.entries(~D[2025-01-01]) |> length() == 2
    assert todo_list |> Todo.List.entries(~D[2025-01-02]) |> length() == 1
    assert todo_list |> Todo.List.entries(~D[2025-01-03]) |> length() == 0

    titles = todo_list |> Todo.List.entries(~D[2025-01-01]) |> Enum.map(& &1.title)

    assert ["New Year's Day", "Movie Night"] == titles
  end

  test "to-do update entry" do
    todo_list =
      Todo.List.new([
        %{date: ~D[2025-01-01], title: "New Year's Day"},
        %{date: ~D[2025-01-02], title: "Shopping"},
        %{date: ~D[2025-01-01], title: "Movie Night"}
      ])

    todo_list =
      todo_list
      |> Todo.List.update_entry(2, &Map.put(&1, :title, "Grocery Shopping"))

    assert Todo.List.size(todo_list) == 3

    assert todo_list |> Todo.List.entries(~D[2025-01-02]) |> hd() == %{
             id: 2,
             date: ~D[2025-01-02],
             title: "Grocery Shopping"
           }

    assert [%{date: ~D[2025-01-02], title: "Grocery Shopping"}] =
             todo_list |> Todo.List.entries(~D[2025-01-02])
  end

  test "to-do delete entry" do
    todo_list =
      Todo.List.new([
        %{date: ~D[2025-01-01], title: "New Year's Day"},
        %{date: ~D[2025-01-02], title: "Shopping"},
        %{date: ~D[2025-01-01], title: "Movie Night"}
      ])

    todo_list = todo_list |> Todo.List.delete_entry(2)

    assert Todo.List.size(todo_list) == 2
    assert todo_list |> Todo.List.entries(~D[2025-01-02]) |> length() == 0
  end
end
