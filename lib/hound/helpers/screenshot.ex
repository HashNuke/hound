defmodule Hound.Helpers.Screenshot do

  @doc "Take screenshot of the current page"
  defmacro take_screenshot do
    quote do: take_screenshot(var!(meta[:session_id]))
  end

end
