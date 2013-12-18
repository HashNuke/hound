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

  def handle_call({:get_session, session_name}, _from, state) do
    session_id = state[:sessions][session_name]
    if session_id do
      {:reply, {state[:options], session_id}, state}
    else
      #TODO fix: Hound.JsonDriver should be suffixed to result "Hound.JsonDriver.Session"
      {:ok, _status, _headers, resp_body} = apply(
        state[:options][:driver],
        :create_session,
        [state[:options][:connection]]
      )

      {:ok, resp} = JSEX.decode(resp_body)
      if resp["sessionId"] == 0 do
        session_id = resp["sessionId"]
        reply = {:ok, state[:options][:connection], session_id}
      else
        reply = {:error, resp["value"]["message"]}
      end

      new_state = ListDict.merge(state, [sessions: [ [{session_name, session_id}] | state[:sessions] ] ])
      IO.inspect "NEW STATE"
      IO.inspect new_state

      { :reply, reply, new_state }
    end
  end


  def handle_call(:active_sessions, _from, state) do
    {:reply, {:ok, state[:sessions]}, state}
  end


  def handle_call({:delete_session, session_id}, _from, state) do
    #TODO destroy specified session
    {:reply, :ok, state}
  end

  #TODO define stop state
end
