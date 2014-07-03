defmodule Hound.JsonDriver.Utils do
  @moduledoc false


  def make_req(type, path, params \\ [], options \\ [], retries \\ 5) do
    if retries > 0 do
      try do
        send_req(type, path, params, options)
      catch
        _ ->
          :timer.sleep(1000)
          make_req(type, path, params, options, retries - 1)
      rescue
        _ ->
          :timer.sleep(1000)
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

    resp = decode_content(content)
    {status, _} = :string.to_integer(status)

    cond do
      status < 300 && path == "session" ->
        {:ok, resp["sessionId"]}
      resp["status"] == 0 ->
        resp["value"]
      is_map(resp["value"]) ->
        resp["value"]["message"]
      status < 400 ->
        :ok
      true ->
        if resp["value"] do
          raise resp["value"]["emessage"]
        else
          raise """
          Webdriver call status code #{status} for #{type} request #{url}.
          Check if webdriver server is running. Make sure it supports the feature being requested.
          """
        end
    end
  end


  defp decode_content(content) do
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
