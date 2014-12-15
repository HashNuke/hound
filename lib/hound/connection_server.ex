defmodule Hound.ConnectionServer do
  @moduledoc false

  use GenServer

  def start_link(options \\ []) do
    driver = options[:driver] || Application.get_env(:hound, :driver, "selenium")

    {default_port, default_path_prefix, default_browser} = case driver do
      "chrome_driver" ->
        {9515, nil, "chrome"}
      "phantomjs" ->
        {8910, nil, "phantomjs"}
      _ -> # assume selenium
        {4444, "wd/hub/", "firefox"}
    end


    browser = options[:browser] || Application.get_env(:hound, :browser, default_browser)
    driver_type = options[:driver_type] || Application.get_env(:hound, :driver_type, Hound.JsonDriver)
    host = options[:host] || Application.get_env(:hound, :host, "http://localhost")
    port = options[:port] || Application.get_env(:hound, :host, default_port)
    path_prefix = options[:path_prefix] || Application.get_env(:hound, :path_prefix, default_path_prefix)


    driver_info = %{
      :driver => driver,
      :browser => browser,
      :driver_type => driver_type,
      :host => host,
      :port => port,
      :path_prefix => path_prefix
    }

    state = %{sessions: [], driver_info: driver_info}
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, state, [])
  end


  def init(state) do
    {:ok, state}
  end


  def handle_call(:driver_info, _from, state) do
    {:reply, state[:driver_info], state}
  end


  def driver_info do
    driver_info = :gen_server.call __MODULE__, :driver_info, 60000
    {:ok, driver_info}
  end

end
