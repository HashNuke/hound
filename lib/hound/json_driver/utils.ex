defmodule Hound.JsonDriver.Utils do

  def make_req(connection, type, path, params // []) do
    host = connection[:host] || "http://localhost"
    port = connection[:port] || 4444
    url  = '#{host}:#{port}/wd/hub/#{path}'

    if params != [] && type == :post do
      {:ok, json} = JSEX.encode params
      IO.inspect json
      {:ok, _status_code, _headers, content} = :ibrowse.send_req(
        url,
        [{'Content-Type', 'application/x-www-form-urlencoded'}],
        type,
        json
      )
    else
      {:ok, _status_code, _headers, content} = :ibrowse.send_req(url, [], type)
    end
  end

end
