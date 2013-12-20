defmodule Hound.SessionServer do
  @moduledoc false

  use GenServer.Behaviour

  def start_link do
    state = []
    :gen_server.start_link({ :local, :hound_sessions }, __MODULE__, state, [])
  end


  def init(state), do: {:ok, state}


  def handle_call(:get_session_for_pid, {pid, _tag}, state) do
    {:ok, driver, _driver_options} = Hound.get_driver_info
    pid_sessions = state[pid]
    if pid_sessions do
      session_id = pid_sessions[:current]
    else
      {:ok, session_id} = driver.create_session()
      session_info = [current: session_id, all_sessions: [default: session_id]]
      state = ListDict.merge(state, [{pid, session_info}])
    end
    {:reply, session_id, state}
  end


  def handle_call({:change_current_session_for_pid, session_name}, {pid, _tag}, state) do
    {:ok, driver, _driver_options} = Hound.get_driver_info
    session_info = state[pid]
    session_id = session_info[:all_sessions][session_name]
    if session_id do
      session_info = ListDict.merge session_info, [current: session_id]
      state = ListDict.merge(state, [{pid, session_info}])
    else
      {:ok, session_id} = driver.create_session()
      all_sessions = ListDict.merge session_info[:all_sessions], [{session_name, session_id}]
      session_info = ListDict.merge session_info, [current: session_id, all_sessions: all_sessions]
      state = ListDict.merge(state, [{pid, session_info}])
    end
    {:reply, session_id, state}
  end


  def handle_call(:destroy_sessions_for_pid, {pid, _tag}, state) do
    {:ok, driver, _driver_options} = Hound.get_driver_info
    pid_sessions = state[pid]
    if pid_sessions do
      lc {_session_name, session_id} inlist pid_sessions[:all_sessions] do
        driver.destroy_session(session_id)
      end
      new_state = ListDict.delete(state, pid)
      {:reply, :ok, new_state}
    else
      {:reply, :ok, state}
    end
  end

end
