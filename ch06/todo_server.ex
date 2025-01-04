defmodule TodoServer do
  use GenServer

  @impl GenServer
  def init(_) do
    {:ok, TodoList.new()}
  end

  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  def add_entry(entry) do
    GenServer.cast(__MODULE__, {:add_entry, entry})
  end

  def entries(date) do
    GenServer.call(__MODULE__, {:entries, date})
  end

  def update_entry(entry_id, updater_fun) do
    GenServer.cast(__MODULE__, {:update_entry, entry_id, updater_fun})
  end

  def delete_entry(entry_id) do
    GenServer.cast(__MODULE__, {:delete_entry, entry_id})
  end

  @impl GenServer
  def handle_call({:entries, date}, _, todo_list) do
    {:reply, TodoList.entries(todo_list, date), todo_list}
  end

  @impl GenServer
  def handle_call(_msg, _from, todo_list) do
    {:reply, todo_list, todo_list}
  end

  @impl GenServer
  def handle_cast({:add_entry, entry}, todo_list) do
    new_todo_list = TodoList.add_entry(todo_list, entry)
    {:noreply, new_todo_list}
  end

  @impl GenServer
  def handle_cast({:update_entry, entry_id, updater_fun}, todo_list) do
    new_todo_list = TodoList.update_entry(todo_list, entry_id, updater_fun)
    {:noreply, new_todo_list}
  end

  @impl GenServer
  def handle_cast({:delete_entry, entry_id}, todo_list) do
    new_todo_list = TodoList.delete_entry(todo_list, entry_id)
    {:noreply, new_todo_list}
  end
end

defmodule TodoList do
  defstruct next_id: 1, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      &add_entry(&2, &1)
    )
  end

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.next_id)
    new_entries = Map.put(todo_list.entries, todo_list.next_id, entry)

    %TodoList{todo_list | entries: new_entries, next_id: todo_list.next_id + 1}
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Map.values()
    |> Enum.filter(fn entry -> entry.date == date end)
  end

  def update_entry(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end

  def delete_entry(todo_list, entry_id) do
    %TodoList{todo_list | entries: Map.delete(todo_list.entries, entry_id)}
  end
end
