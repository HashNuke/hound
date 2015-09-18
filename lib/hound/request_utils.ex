defmodule Hound.RequestUtils do
  @moduledoc false

  @retry_time Application.get_env(:hound, :retry_time, 250)

  @http_options Application.get_env(:hound, :http, [])


  def make_req(type, path, params \\ %{}, options \\ %{}, retries \\ 0) do
    if retries > 0 do
      try do
        send_req(type, path, params, options)
      catch
        _ ->
          :timer.sleep(@retry_time)
          make_req(type, path, params, options, retries - 1)
      rescue
        _ ->
          :timer.sleep(@retry_time)
          make_req(type, path, params, options, retries - 1)
      end
    else
      send_req(type, path, params, options)
    end
  end


  defp send_req(type, path, params, options) do
    url = get_url(path)

    if params != %{} && type == :post do
      headers = [{"Content-Type", "text/json"}]
      if options[:json_encode] != false do
        body = Poison.encode! params
      else
        body = params
      end
    else
      headers = []
      body = ""
    end

    case type do
      :get ->
        {:ok, resp} = HTTPoison.get(url, headers, @http_options)
      :post ->
        {:ok, resp} = HTTPoison.post(url, body, headers, @http_options)
      :delete ->
        {:ok, resp} = HTTPoison.delete(url, headers, @http_options)
    end

    case response_parser.parse(path, resp.status_code, resp.body) do
      :error ->
        raise """
        Webdriver call status code #{resp.status_code} for #{type} request #{url}.
        Check if webdriver server is running. Make sure it supports the feature being requested.
        """
      response -> response
    end
  end


  defp response_parser do
    {:ok, driver_info} = Hound.driver_info
    case driver_info.driver do
      "selenium" ->
        Hound.ResponseParsers.Selenium
      "chrome_driver" ->
        Hound.ResponseParsers.ChromeDriver
      "phantomjs" ->
        Hound.ResponseParsers.PhantomJs
      other_driver ->
        raise "No response parser found for #{other_driver}"
    end
  end


  def decode_content(content) do
    if content != [] do
      Poison.decode!(content)
    else
      Map.new
    end
  end


  defp get_url(path) do
    {:ok, driver_info} = Hound.driver_info

    host = driver_info[:host]
    port = driver_info[:port]
    path_prefix = driver_info[:path_prefix]

    "#{host}:#{port}/#{path_prefix}#{path}"
  end

end
