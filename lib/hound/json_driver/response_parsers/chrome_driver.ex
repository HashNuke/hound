defmodule Hound.JsonDriver.ResponseParsers.ChromeDriver do
  @moduledoc false

  def parse(path, status, content) do
    resp = Hound.JsonDriver.Utils.decode_content(content)

    value = resp["value"]
    cond do
      status < 300 && path == "session" ->
        {:ok, resp["sessionId"]}
      is_error?(value) ->
        raise value["message"]
      is_warning?(value) ->
        warn value["message"]
        value
      resp["status"] == 0 ->
        value
      status < 400 ->
        :ok
      true -> :error
    end
  end


  defp is_error?(value) do
    is_map(value) && Map.has_key?(value, "message") && !is_warning?(value)
  end


  defp is_warning?(value) do
    if is_map(value) && Map.has_key?(value, "message") do
      Regex.match?(~r/#{Regex.escape("not clickable")}/, value["message"])
    else
      false
    end
  end


  defp warn(message) do
    IO.puts "WARNING: #{message}"
  end
end
