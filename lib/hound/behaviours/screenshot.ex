defmodule Hound.Behaviours.Screenshot do
  use Behaviour

  @doc "Take screenshot of the current page"
  defcallback take_screenshot(session_id :: String.t)
end
