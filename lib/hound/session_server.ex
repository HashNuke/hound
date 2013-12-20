defmodule Hound.SessionServer do
  use GenServer.Behaviour

  def start_link(options // []) do
    state = []
    :gen_server.start_link({ :local, :hound_sessions }, __MODULE__, state, [])
  end


  def init(state), do: {:ok, state}


  def handle_call(:get_session_for_pid, from, state) do
    {:ok, driver, driver_options} = Hound.get_driver_info
    pid_sessions = state[from]
    if pid_sessions do
      session_id = pid_sessions[:current]
    else
      {:ok, session_id} = driver.create_session()
      session_info = [current: session_id, all_sessions: [default: session_id]]
      state = ListDict.merge(state, [{from, session_info}])
    end
    {:reply, session_id, state}
  end


  def handle_call({:change_current_session_for_pid, session_name}, from, state) do
    {:ok, driver, driver_options} = Hound.get_driver_info
    session_info = state[from]
    session_id = session_info[:all_sessions][session_name]
    if session_id do
      session_info = ListDict.merge session_info, [current: session_id]
      state = ListDict.merge(state, [{from, session_info}])
    else
      {:ok, session_id} = driver.create_session(driver_options)
      all_sessions = ListDict.merge session_info[:all_sessions], [{session_name, session_id}]
      session_info = ListDict.merge session_info, [current: session_id, all_sessions: all_sessions]
      state = ListDict.merge(state, [{from, session_info}])
    end
    {:reply, session_id, state}
  end


  def handle_call(:destroy_sessions_for_pid, from, state) do
    pid_sessions = state[:sessions][from]
    if pid_sessions do
      lc {session_name, session_id} inlist pid_sessions[:all_sessions] do
        state[:driver].destroy_session(session_id)
      end
      new_state = ListDict.delete(state, from)
      {:reply, :ok, new_state}
    else
      {:reply, :ok, state}
    end
  end

end
