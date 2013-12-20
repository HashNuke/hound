defmodule Hound.ConnectionServer do
  use GenServer.Behaviour

  def start_link(options // []) do
    state = [
      sessions: [],
      driver_options: options[:driver_options] || [],
      driver: options[:driver] || Hound.JsonDriver
    ]
    :gen_server.start_link({ :local, :hound_connection }, __MODULE__, state, [])
  end

  def init(state), do: {:ok, state}

  def handle_call(:driver_info, _from, state) do
    {:reply, {:ok, state[:driver], state[:driver_options]}, state}
  end

end
