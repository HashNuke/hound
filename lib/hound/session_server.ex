defmodule Hound.SessionServer do
  use GenServer.Behaviour

  def start_link(options // []) do
    state = [
      sessions: [],
      options: [
        connection: options[:connection] || [],
        driver: options[:driver] || Hound.JsonDriver
      ]
    ]

    :gen_server.start_link({ :local, :hound }, __MODULE__, state, [])
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:get_session, session_name}, from, state) do
    session_id = state[:sessions][session_name]
    if session_id do
      {:reply, {state[:options], "TODO sessionID"}, state}
    else
      #TODO create session from config
      { :reply,
        {state[:options][:connection], "TODO sessionID"},
        ListDict.merge(state, [sessions: [ [{session_name, session_id}] | state[:sessions] ] ])
      }
    end
  end

  def handle_call({:delete_session, session_id}, from, state) do
    #TODO create session from config    
    {:reply, :ok, state}
  end

  #TODO define stop state
end
