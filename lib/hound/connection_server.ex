defmodule Hound.ConnectionServer do
  @moduledoc false

  use GenServer.Behaviour

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

    browser = options[:browser]  || default_browser
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

    Agent.start_link(fn->
      %{sessions: [], driver_info: driver_info}
    end, name: __MODULE__)
  end


  def driver_info do
    Agent.get __MODULE__, fn(state)->
      {:ok, state[:driver_info]}
    end
  end

end
