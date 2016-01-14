defmodule Hound.ResponseParserUtils do
  @moduledoc false

  require Logger

  def is_error?(value) do
    is_map(value) && Map.has_key?(value, "message")
  end


  def is_warning?(value) do
    if is_map(value) && Map.has_key?(value, "message") do
      Regex.match?(~r/#{Regex.escape("not clickable")}/, value["message"])
    else
      false
    end
  end


  def warn(message) do
    Logger.warn message
  end
end
