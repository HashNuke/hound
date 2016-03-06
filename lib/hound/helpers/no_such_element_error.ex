defmodule Hound.NoSuchElementError do
  defexception [:strategy, :selector, :parent]

  def message(err) do
    parent_text = if err.parent, do: "in #{err.parent} ", else: ""
    "No element #{parent_text}found for #{err.strategy} '#{err.selector}'"
  end
end
