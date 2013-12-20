defmodule Hound.JsonDriver.Utils do

  def make_req(type, path, params // []) do
    {:ok, _driver, driver_info} = Hound.get_driver_info
    host = driver_info[:host] || "http://localhost"
    port = driver_info[:port] || 4444
    url  = '#{host}:#{port}/wd/hub/#{path}'

    if params != [] && type == :post do
      {:ok, json} = JSEX.encode params
      {:ok, status, headers, content} = :ibrowse.send_req(
        url, [{'Content-Type', 'application/x-www-form-urlencoded'}], type, json
      )
    else
      {:ok, status, headers, content} = :ibrowse.send_req(url, [], type)
    end

    if content != [] do
      {:ok, resp} = JSEX.decode("#{content}")
    else
      resp = []
    end

    cond do
      resp["status"] == 0 && path == "session" ->
        {:ok, resp["sessionId"]}
      resp["status"] == 0 ->
        resp["value"]
      status < 300 || status == nil ->
        :ok
      true ->
        {:error, resp["value"]}
    end
  end

end
