defmodule Hound.Helpers.Navigation do

  @doc "Get url of the current page"
  defmacro current_url do
    quote do: current_url(var!(meta[:session_id]))
  end

  @doc "Navigate to a url"
  defmacro navigate_to(url) do
    quote do: navigate_to(var!(meta[:session_id]), url)
  end

  @doc "Navigate forward in browser history"
  defmacro navigate_forward do
    quote do: navigate_forward(var!(meta[:session_id]))
  end

  @doc "Navigate back in browser history"
  defmacro navigate_back do
    quote do: navigate_back(var!(meta[:session_id]))
  end

  @doc "Refresh current page"
  defmacro refresh do
    quote do: refresh(var!(meta[:session_id]))
  end

end
