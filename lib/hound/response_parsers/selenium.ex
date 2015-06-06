defmodule Hound.ResponseParsers.Selenium do
  @moduledoc false

  import Hound.ResponseParserUtils

  def parse(path, status, content) do
    resp = Hound.RequestUtils.decode_content(content)

    value = resp["value"]
    cond do
      status < 300 && path == "session" ->
        {:ok, resp["sessionId"]}
      is_warning?(value) ->
        warn value["message"]
        value
      is_error?(value) ->
        raise value["message"]
      resp["status"] == 0 ->
        resp["value"]
      status < 400 ->
        :ok
      true -> :error
    end
  end

end
