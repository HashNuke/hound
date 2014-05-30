defmodule Hound.SessionServer do
  @moduledoc false

  use GenServer.Behaviour

  def start_link do
    state = HashDict.new
    :gen_server.start_link({ :local, :hound_sessions }, __MODULE__, state, [])
  end


  def init(state), do: {:ok, state}


  def handle_call(:get_session_for_pid, {pid, _tag}, state) do
    {:ok, driver_info} = Hound.get_driver_info
    pid_sessions = HashDict.get(state, pid)
    if pid_sessions do
      session_id = pid_sessions[:current]
    else
      {:ok, session_id} = driver_info[:type].create_session(driver_info[:browser])
      session_info = [current: session_id, all_sessions: [default: session_id]]
      state = HashDict.put(state, pid, session_info)
    end
    {:reply, session_id, state}
  end


  def handle_call({:change_current_session_for_pid, session_name}, {pid, _tag}, state) do
    {:ok, driver_info} = Hound.get_driver_info
    session_info = state[pid]
    session_id = session_info[:all_sessions][session_name]
    if session_id do
      session_info = HashDict.put session_info, :current, session_id
      state = HashDict.merge(state, pid, session_info)
    else
      {:ok, session_id} = driver_info[:type].create_session(driver_info[:browser])
      all_sessions = HashDict.merge session_info[:all_sessions], session_name, session_id
      session_info = HashDict.merge session_info, :current, session_id
      session_info = HashDict.merge session_info, :all_sessions, all_sessions
      state = HashDict.merge(state, pid, session_info)
    end
    {:reply, session_id, state}
  end


  def handle_call(:all_sessions_for_pid, {pid, _tag}, state) do
    if state[pid] do
      {:reply, state[pid][:all_sessions], state}
    else
      {:reply, [], state}
    end
  end


  def handle_call(:destroy_sessions_for_pid, {pid, _tag}, state) do
    {:ok, driver} = Hound.get_driver_info
    pid_sessions = state[pid]
    if pid_sessions do
      for {_session_name, session_id} <- pid_sessions[:all_sessions] do
        driver[:type].destroy_session(session_id)
      end
      new_state = HashDict.delete(state, pid)
      {:reply, :ok, new_state}
    else
      {:reply, :ok, state}
    end
  end

end
