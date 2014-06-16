defmodule Hound.SessionServer do
  @moduledoc false

  def start_link do
    state = HashDict.new
    Agent.start_link(fn -> HashDict.new() end, name: __MODULE__)
  end


  def session_for_pid(pid) do
    Agent.get_and_update __MODULE__, fn(state)->
      {:ok, driver_info} = Hound.driver_info
      pid_sessions = HashDict.get(state, pid)

      session_id = if HashDict.has_key?(state, pid) do
          state[pid][:current]
        else
          nil
        end


      if session_id do
        {session_id, state}
      else
        {:ok, session_id} = driver_info[:driver_type].create_session(driver_info[:browser])

        all_sessions = HashDict.new
        |> HashDict.put :default, session_id

        session_info = HashDict.new
          |> HashDict.put(:current, session_id)
          |> HashDict.put(:all_sessions, all_sessions)

        state_upgrade = HashDict.new |> HashDict.put(pid, session_info)
        new_state = HashDict.merge(state, state_upgrade)
        {session_id, new_state}
      end
    end, 60000
  end


  def current_session_id(pid) do
    Agent.get __MODULE__, fn(state)->
      if HashDict.has_key?(state, pid) do
        state[pid][:current]
      else
        []
      end
    end, 30000
  end


  def change_current_session_for_pid(pid, session_name) do
    Agent.get_and_update __MODULE__, fn(state)->
      {:ok, driver_info} = Hound.driver_info

      pid_info = state[pid]
      session_id = pid_info[:all_sessions][session_name]

      if session_id do
        pid_info_update = HashDict.put(pid_info, :current, session_id)
        new_state = HashDict.put(state, pid, pid_info_update)
      else
        {:ok, session_id} = driver_info[:driver_type].create_session(driver_info[:browser])

        all_sessions_update = HashDict.put(pid_info[:all_sessions], session_name, session_id)
        pid_info_update = pid_info
          |> HashDict.put(:current, session_id)
          |> HashDict.put(:all_sessions, all_sessions_update)
        new_state = HashDict.put(state, pid, pid_info_update)
      end
      {session_id, new_state}
    end, 30000
  end


  def all_sessions_for_pid(pid) do
    Agent.get __MODULE__, fn(state)->
      if HashDict.has_key?(state, pid) do
        state[pid][:all_sessions]
      else
        []
      end
    end
  end


  def destroy_sessions_for_pid(pid) do
    Agent.get_and_update __MODULE__, fn(state)->
      {:ok, driver} = Hound.driver_info

      sessions = if HashDict.has_key?(state, pid) do
          state[pid][:all_sessions]
        else
          []
        end


      Enum.each sessions, fn({_session_name, session_id})->
        driver[:driver_type].destroy_session(session_id)
      end
      new_state = HashDict.delete(state, pid)
      {:ok, new_state}
    end, 30000
  end

end
