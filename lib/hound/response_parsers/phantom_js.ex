defmodule Hound.ResponseParsers.PhantomJs do
  @moduledoc false

  def parse(path, status, content) do
    resp = Hound.RequestUtils.decode_content(content)
    value = resp["value"]

    cond do
      status < 300 && path == "session" ->
        {:ok, resp["sessionId"]}

      resp["status"] == 0 -> value

      is_map(resp["value"]) && Map.has_key?(value, "message") ->
        case Poison.decode(value["message"]) do
          {:ok, decoded_error} ->
            raise decoded_error["errorMessage"]
          _ ->
            raise value
        end

      status < 400 -> :ok
      true         -> :error
    end
  end

end
