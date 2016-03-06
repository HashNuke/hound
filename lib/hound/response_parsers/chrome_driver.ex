defmodule Hound.ResponseParsers.ChromeDriver do
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
        handle_error(value)
      resp["status"] == 0 ->
        value
      status < 400 ->
        :ok
      true -> :error
    end
  end

  defp handle_error(%{"message" => "no such element" <> _rest}),
    do: {:error, :no_such_element}
  defp handle_error(%{"message" => msg}),
    do: {:error, msg}
end
