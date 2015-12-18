defmodule Hound.SessionServer do
  @moduledoc false

  use GenServer

  def start_link do
    state = %{}
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, state, [])
  end


  def init(state) do
    {:ok, state}
  end


  def handle_call({:find_or_create_session, pid}, _from, state) do
    {:ok, driver_info} = Hound.driver_info

    case state[pid][:current] do
      nil ->
        {:ok, session_id} = Hound.Session.create_session(driver_info[:browser])

        all_sessions = %{default: session_id}
        session_info = %{current: session_id, all_sessions: all_sessions}
        state_upgrade = %{} |> Map.put(pid, session_info)
        new_state = Map.merge(state, state_upgrade)
        {:reply, session_id, new_state}
      session_id ->
        {:reply, session_id, state}
    end
  end


  def handle_call({:current_session, pid}, _from, state) do
    if Map.has_key?(state, pid) do
      {:reply, state[pid][:current], state}
    else
      {:reply, nil, state}
    end
  end


  def handle_call({:change_session, pid, session_name}, _from, state) do
    {:ok, driver_info} = Hound.driver_info

    pid_info = state[pid]
    session_id = pid_info[:all_sessions][session_name]

    if session_id do
      pid_info_update = Map.put(pid_info, :current, session_id)
    else
      {:ok, session_id} = Hound.Session.create_session(driver_info[:browser])

      all_sessions_update = Map.put(pid_info[:all_sessions], session_name, session_id)
      pid_info_update = Map.merge(pid_info, %{
        current: session_id,
        all_sessions: all_sessions_update
      })
    end

    new_state = Map.put(state, pid, pid_info_update)
    {:reply, session_id, new_state}
  end


  def handle_call({:all_sessions, pid}, _from, state) do
    if Map.has_key?(state, pid) do
      {:reply, state[pid][:all_sessions], state}
    else
      {:reply, [], state}
    end
  end


  def handle_call({:destroy_sessions, pid}, _from, state) do
    if Map.has_key?(state, pid) do
      sessions = state[pid][:all_sessions]
      Enum.each sessions, fn({_session_name, session_id})->
        Hound.Session.destroy_session(session_id)
      end
      state = Map.delete(state, pid)
    end
    {:reply, :ok, state}
  end


  def session_for_pid(pid) do
    :gen_server.call __MODULE__, {:find_or_create_session, pid}, 60000
  end


  def current_session_id(pid) do
    :gen_server.call __MODULE__, {:current_session, pid}, 30000
  end


  def change_current_session_for_pid(pid, session_name) do
    :gen_server.call __MODULE__, {:change_session, pid, session_name}, 30000
  end


  def all_sessions_for_pid(pid) do
    :gen_server.call __MODULE__, {:all_sessions, pid}, 30000
  end


  def destroy_sessions_for_pid(pid) do
    :gen_server.call __MODULE__, {:destroy_sessions, pid}, 30000
  end

end
