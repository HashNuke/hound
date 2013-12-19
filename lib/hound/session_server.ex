defmodule Hound.SessionServer do
  use GenServer.Behaviour

  def start_link(options // []) do
    state = [
      driver_options: options[:driver_options] || [],
      driver: options[:driver] || Hound.JsonDriver
    ]
    :gen_server.start_link({ :local, :hound }, __MODULE__, state, [])
  end

  def init(state), do: {:ok, state}

  def handle_call(:driver_info, _from, state) do
    {:ok, state[:driver], state[:driver_options]}
  end

end
