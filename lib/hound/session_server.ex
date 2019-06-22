defmodule Hound.SessionServer do
  @moduledoc false

  use GenServer
  @name __MODULE__

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: @name)
  end


  def session_for_pid(pid, opts) do
    {:ok, current_session_id(pid)} ||
      change_current_session_for_pid(pid, :default, opts)
  end


  def current_session_id(pid) do
    case :ets.lookup(@name, pid) do
      [{^pid, _ref, session_id, _all_sessions}] -> session_id
      [] -> nil
    end
  end

  def current_session_name(pid) do
    case :ets.lookup(@name, pid) do
      [{^pid, _ref, session_id, all_sessions}] ->
        Enum.find_value all_sessions, fn
          {name, id} when id == session_id -> name
          _ -> nil
        end
      [] -> nil
    end
  end


  def change_current_session_for_pid(pid, session_name, opts) do
    GenServer.call(@name, {:change_session, pid, session_name, opts}, genserver_timeout())
  end


  def all_sessions_for_pid(pid) do
    case :ets.lookup(@name, pid) do
      [{^pid, _ref, _session_id, all_sessions}] -> all_sessions
      [] -> %{}
    end
  end


  def destroy_sessions_for_pid(pid) do
    GenServer.call(@name, {:destroy_sessions, pid}, 60000)
  end

  ## Callbacks

  def init(state) do
    :ets.new(@name, [:set, :named_table, :protected, read_concurrency: true])
    {:ok, state}
  end

  def handle_call({:destroy_sessions, pid}, _from, state) do
    destroy_sessions(pid)
    {:reply, :ok, state}
  end

  def handle_call({:change_session, pid, session_name, opts}, _from, state) do
    {ref, sessions} = case :ets.lookup(@name, pid) do
      [{^pid, ref, _session_id, sessions}] ->
        {ref, sessions}
      [] ->
        {Process.monitor(pid), %{}}
    end


    case find_existing_session(sessions, session_name) do
      {:ok, {session_id, sessions}} ->
        add_session_to_table(pid, ref, session_id, sessions)

        {:reply, {:ok, session_id}, Map.put(state, ref, pid)}

      :error ->
        {:ok, driver_info} = Hound.driver_info()

        case create_session(driver_info, opts) do
          {:error, _} = e -> {:reply, e, state}

          {:ok, session_id} ->
            sessions = Map.put(sessions, session_name, session_id)
            add_session_to_table(pid, ref, session_id, sessions)

            {:reply, {:ok, session_id}, Map.put(state, ref, pid)}
        end
    end
  end

  defp add_session_to_table(pid, ref, session_id, sessions) do
    :ets.insert(@name, {pid, ref, session_id, sessions})
  end

  defp find_existing_session(sessions, session_name) do
    with {:ok, session_id} <- Map.fetch(sessions, session_name) do
       {:ok, {session_id, sessions}}
    end
  end

  def handle_info({:DOWN, ref, _, _, _}, state) do
    if pid = state[ref] do
      destroy_sessions(pid)
    end
    {:noreply, state}
  end

  defp create_session(driver_info, opts) do
    Hound.Session.create_session(driver_info[:browser], opts)
  end

  defp destroy_sessions(pid) do
    sessions = all_sessions_for_pid(pid)
    :ets.delete(@name, pid)
    Enum.each sessions, fn({_session_name, session_id})->
      Hound.Session.destroy_session(session_id)
    end
  end

  defp genserver_timeout() do
    Application.get_env(:hound, :genserver_timeout, 60000)
  end
end
