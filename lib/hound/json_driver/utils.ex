defmodule Hound.JsonDriver.Utils do
  def make_req(connection, type, url, params // []) do
    host = connection[:host] || "http://localhost"
    port = connection[:port] || 4444
    url  = "#{host}:#{port}/#{url}"
  end
end