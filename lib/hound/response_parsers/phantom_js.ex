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
            decoded_error
          _ ->
            value
        end
        |> handle_error

      status < 400 -> :ok
      true         -> :error
    end
  end

  defp handle_error(%{"errorMessage" => "Unable to find element" <> _rest}),
    do: {:error, :no_such_element}
  defp handle_error(%{"errorMessage" => msg}),
    do: {:error, msg}
  defp handle_error(err),
    do: {:error, err}
end
