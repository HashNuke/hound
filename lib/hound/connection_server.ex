defmodule Hound.ConnectionServer do
  @moduledoc false

  use GenServer.Behaviour

  def start_link(options // []) do
    driver = options[:driver] || :selenium
    {default_port, path_prefix} = case driver do
      :chrome_driver ->
        {9515, nil}
      :phantomjs ->
        {8910, "wd/hub"}
      _ -> # assume selenium
        {4444, "wd/hub"}
    end

    driver_info = [
      driver: driver,
      type: options[:driver_type] || Hound.JsonDriver,
      host: options[:host] || "http://localhost",
      port: options[:port] || default_port,
      path_prefix: options[:path_prefix]
    ]

    state = [sessions: [], driver_info: driver_info]

    :gen_server.start_link({ :local, :hound_connection }, __MODULE__, state, [])
  end


  def init(state), do: {:ok, state}


  def handle_call(:driver_info, _from, state) do
    {:reply, {:ok, state[:driver_info]}, state}
  end

end
