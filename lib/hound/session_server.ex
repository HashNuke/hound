defmodule Hound.SessionServer do
  @moduledoc false

  use GenServer
  @name __MODULE__

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: @name)
  end


  def session_for_pid(pid, opts) do
    current_session_id(pid) ||
      change_current_session_for_pid(pid, :default, opts)
  end


  def current_session_id(pid) do
    case :ets.lookup(@name, pid) do
      [{^pid, session_id, _all_sessions}] -> session_id
      [] -> nil
    end
  end

  def current_session_name(pid) do
    case :ets.lookup(@name, pid) do
      [{^pid, session_id, all_sessions}] ->
        Enum.find_value all_sessions, fn
          {name, id} when id == session_id -> name
          _ -> nil
        end
      [] -> nil
    end
  end


  def change_current_session_for_pid(pid, session_name, opts) do
    {:ok, session_id} =
      GenServer.call(@name, {:change_session, pid, session_name, opts}, 60000)
    session_id
  end


  def all_sessions_for_pid(pid) do
    case :ets.lookup(@name, pid) do
      [{^pid, _session_id, all_sessions}] -> all_sessions
      [] -> %{}
    end
  end


  def all_sessions do
    :ets.foldl(fn {_pid, _session_id, sessions}, acc -> acc ++ Map.values(sessions) end, [], @name)
  end


  def destroy_sessions_for_pid(pid) do
    GenServer.call(@name, {:destroy_sessions, pid}, 60000)
  end

  ## Callbacks

  def init(state) do
    :ets.new(@name, [:set, :named_table, :protected, read_concurrency: true])
    {:ok, state}
  end


  def handle_call({:change_session, pid, session_name, opts}, _from, state) do
    {:ok, driver_info} = Hound.driver_info

    sessions =
      case :ets.lookup(@name, pid) do
        [{^pid, _session_id, sessions}] ->
          sessions
        [] -> %{}
      end

    {session_id, sessions} =
      case Map.fetch(sessions, session_name) do
        {:ok, session_id} ->
          {session_id, sessions}
        :error ->
          session_id = create_session(driver_info, opts)
          {session_id, Map.put(sessions, session_name, session_id)}
      end

    :ets.insert(@name, {pid, session_id, sessions})
    {:reply, {:ok, session_id}, monitor_session(pid, state)}
  rescue
    error -> {:reply, {:error, error}, state}
  end

  def handle_call({:destroy_sessions, pid}, _from, state) do
    destroy_sessions(pid)
    {:reply, :ok, state}
  end

  def handle_info({:DOWN, ref, _, _, _}, state) do
    if pid = state[ref] do
      destroy_sessions(pid)
    end
    {:noreply, state}
  end

  defp monitor_session(pid, state) do
    if state |> Map.values |> Enum.member?(pid) do
      state
    else
      ref = Process.monitor(pid)
      Map.put(state, ref, pid)
    end
  end

  defp create_session(driver_info, opts) do
    case Hound.Session.create_session(driver_info[:browser], opts) do
      {:ok, session_id} -> session_id
      {:error, reason} -> raise "could not create a new session: #{reason}, check webdriver is running"
    end
  end

  defp destroy_sessions(pid) do
    sessions = all_sessions_for_pid(pid)
    :ets.delete(@name, pid)
    Enum.each sessions, fn({_session_name, session_id})->
      spawn fn -> destroy_session(session_id) end
    end
  end

  defp destroy_session(session_id) do
    Hound.Session.destroy_session(session_id)
  rescue Hound.Error -> false
  end
end
