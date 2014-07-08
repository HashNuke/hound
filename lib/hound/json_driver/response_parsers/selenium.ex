defmodule Hound.JsonDriver.ResponseParsers.Selenium do
  @moduledoc false

  def parse(path, status, content) do
    resp = Hound.JsonDriver.Utils.decode_content(content)

    cond do
      status < 300 && path == "session" ->
        {:ok, resp["sessionId"]}
      is_map(resp["value"]) && Map.has_key?(resp["value"], "message") ->
        raise resp["value"]["message"]
      resp["status"] == 0 ->
        resp["value"]
      status < 400 ->
        :ok
      true -> :error
    end
  end

end
