defmodule Hound.ServerServer do
  use GenServer.Behaviour

  def start_link(options // []) do
    state = [sessions: []]
    :gen_server.start_link({ :local, :hound }, __MODULE__, state, [])
  end

  def init(state), do: {:ok, state}

  def handle_call({:get_session_for_pid, pid}, _from, state) do
    {:reply, state[:sessions][pid], state}
  end

  def handle_cast({:destroy_session_for_pid, pid}, _from, state) do
    #TODO destroy session
    {:reply, state}
  end
end
