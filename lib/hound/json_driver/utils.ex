defmodule Hound.JsonDriver.Utils do
  @moduledoc false

  def make_req(type, path, params \\ [], options \\ [], retries \\ 0) do

    if retries > 0 do
      try do
        send_req(type, path, params, options)
      catch
        _ ->
          :timer.sleep(500)
          make_req(type, path, params, options, retries - 1)
      rescue
        _ ->
          :timer.sleep(500)
          make_req(type, path, params, options, retries - 1)
      end
    else
      send_req(type, path, params, options)
    end
  end


  defp send_req(type, path, params, options) do
    url = get_url(path)

    if params != [] && type == :post do
      headers = [{'Content-Type', 'text/json'}]
      if options[:json_encode] != false do
        {:ok, body} = JSEX.encode params
      else
        body = params
      end
    else
      headers = []
      body = ""
    end

    {:ok, status, _headers, content} = :ibrowse.send_req(url, headers, type, body)

    {status, _} = :string.to_integer(status)
    case response_parser.parse(path, status, content) do
      :error ->
        raise """
        Webdriver call status code #{status} for #{type} request #{url}.
        Check if webdriver server is running. Make sure it supports the feature being requested.
        """
      response -> response
    end
  end


  defp response_parser do
    {:ok, driver_info} = Hound.driver_info
    case driver_info.driver do
      "selenium" ->
        Hound.JsonDriver.ResponseParsers.Selenium
      "chrome_driver" ->
        Hound.JsonDriver.ResponseParsers.ChromeDriver
      "phantomjs" ->
        Hound.JsonDriver.ResponseParsers.PhantomJs
      other_driver ->
        raise "No response parser found for #{other_driver}"
    end
  end


  def decode_content(content) do
    if content != [] do
      json_string = IO.iodata_to_binary(content)
      {:ok, resp} = JSEX.decode(json_string)
      resp
    else
      Map.new
    end
  end


  defp get_url(path) do
    {:ok, driver_info} = Hound.driver_info

    host = driver_info[:host]
    port = driver_info[:port]
    path_prefix = driver_info[:path_prefix]

    '#{host}:#{port}/#{path_prefix}#{path}'
  end

end
