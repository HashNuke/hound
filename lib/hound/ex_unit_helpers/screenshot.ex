defmodule Hound.ExUnitHelpers.Screenshot do

  @doc "Take screenshot of the current page"
  defmacro take_screenshot do
    quote do
      take_screenshot(var!(meta)[:hound_connection], var!(meta)[:hound_session_id])
    end
  end

end
