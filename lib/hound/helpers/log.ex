defmodule Hound.Helpers.Log do
  @moduledoc "Functions to work with the log"

  import Hound.RequestUtils
  require Hound.NotSupportedError

  @doc """
  Fetches console.log() from the browser as a single string of log-lines.
  """
  def fetch_log() do
    fail_if_webdriver_selenium("fetch_log()")
    
    get_browser_log()
    |> Enum.map_join("\n", &(Map.get(&1, "message")))
  end

  @doc """
  Fetches all console.log() lines of type 'WARINING' and CRITICAL, from the browser as a single string of log-lines.
  """
  def fetch_errors() do
    fail_if_webdriver_selenium("fetch_errors()")
    
    get_browser_log()
    |> Enum.filter(&(is_error(&1)))
    |> Enum.map_join("\n", &(Map.get(&1, "message")))
  end

  defp fail_if_webdriver_selenium(function) do
    Hound.NotSupportedError.raise_for(%{driver: "selenium", browser: "firefox"}, function)
  end

  defp get_browser_log() do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/log", %{type: "browser"})
  end

  defp is_error(map) do
    level(map, "WARNING") || level(map, "CRITICAL")
  end
  
  defp level(map, value) do
    Map.get(map, "level") == value
  end
end
