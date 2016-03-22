defmodule Hound.NoSuchElementError do
  defexception [:strategy, :selector, :parent]

  def message(err) do
    parent_text = if err.parent, do: "in #{err.parent} ", else: ""
    "No element #{parent_text}found for #{err.strategy} '#{err.selector}'"
  end
end

defmodule Hound.InvalidElementError do
  defexception [:value]

  def message(err) do
    "Could not transform value #{inspect(err.value)} to element"
  end
end

defmodule Hound.NotSupportedError do
  defexception [:function, :browser, :driver]

  def message(err) do
    {:ok, info} = Hound.ConnectionServer.driver_info
    driver = err.driver || info.driver
    browser = err.browser || info.browser
    "#{err.function} is not supported by driver #{driver} with browser #{browser}"
  end
end
