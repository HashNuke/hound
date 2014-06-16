defmodule Hound.JsonDriver.Utils do
  @moduledoc false

  def make_req(type, path, params \\ [], options \\ []) do
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
      status < 400 ->
        :ok
      true ->
        if resp["value"] do
          raise resp["value"]["message"]
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
      {:ok, resp} = JSEX.decode(iodata_to_binary content)
      resp
    else
      []
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
