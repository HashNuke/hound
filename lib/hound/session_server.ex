defmodule Hound.SessionServer do
  @moduledoc false

  def start_link do
    state = HashDict.new
    Agent.start_link(fn -> HashDict.new() end, name: __MODULE__)
  end


  def session_for_pid(pid) do
    Agent.get_and_update __MODULE__, fn(state)->
      {:ok, driver_info} = Hound.get_driver_info
      pid_sessions = HashDict.get(state, pid)

      session_id = get_in state[pid][:current]

      if session_id do
        {session_id, state}
      else
        {:ok, session_id} = driver_info[:type].create_session(driver_info[:browser])

        all_sessions = HashDict.new
        |> HashDict.put :default, session_id

        #TODO following is supposed to be a hashdict
        session_info = %{:current => session_id, :all_sessions => all_sessions}
        state = put_in(state[pid], session_info)
        {session_id, state}
      end
    end, 60000
  end


  def current_session_id(pid) do
    Agent.get __MODULE__, fn(state)->
      get_in state[pid][:current]
    end, 30000
  end


  def change_current_session_for_pid(pid, session_name) do
    Agent.get_and_update __MODULE__, fn(state)->
      {:ok, driver_info} = Hound.get_driver_info

      session_info = state[pid]
      session_id = get_in session_info[:all_sessions][session_name]

      if session_id do
        state = put_in state[pid][:current], session_id
      else
        {:ok, session_id} = driver_info[:type].create_session(driver_info[:browser])
        state = put_in state[pid][:all_sessions][session_name], session_id
        state = put_in state[pid][:current], session_id
        state = put_in state[pid][:all_sessions], all_sessions
      end
      {session_id, state}
    end, 30000
  end



  def all_sessions_for_pid(pid) do
    Agent.get __MODULE__, fn(state)->
      get_in state[pid][:all_sessions] || []
    end
  end


  def destroy_sessions_for_pid(pid) do
    Agent.get_and_update __MODULE__, fn(state)->
      {:ok, driver} = Hound.get_driver_info
      sessions = get_in(state[pid][:all_sessions]) || []
      Enum.each sessions, fn({_session_name, session_id})->
        driver[:type].destroy_session(session_id)
      end
      new_state = HashDict.delete(state, pid)
      {:ok, new_state}
    end, 30000
  end

end
