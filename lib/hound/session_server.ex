defmodule Hound.SessionServer do
  use GenServer.Behaviour

  def start_link(options // []) do
    driver = options[:driver] || "selenium"
    connection = options[:connection]
    :gen_server.start_link(__MODULE__, [sessions: [], options: connection], [])
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:get_session, session_name}, from, state) do
    session_id = state.sessions[session_name]
    if session_id do
      {:reply, session_id, state}
    else
      #TODO create session from config
      {:reply, "TODO sessionID", [sessions: [ [{session_name, session_id}] | state.sessions ], options: state.options]}
    end
  end

  def handle_call({:delete_session, session_id}, from, state) do
    #TODO create session from config
    {:reply, :ok, state}
  end
end
