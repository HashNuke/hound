defmodule Hound.ScreenshotBehaviour do
  use Behaviour

  @doc "Take screenshot of the current page"
  defcallback take_screenshot(session_id :: String.t)
end
