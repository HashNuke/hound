defmodule Hound.Helpers.Navigation do

  @doc "Get url of the current page"
  defmacro current_url do
    quote do: current_url(var!(meta[:hound_connection]), var!(meta[:hound_session_id]))
  end


  @doc "Navigate to a url"
  defmacro navigate_to(url) do
    quote do
      navigate_to(
        var!(meta[:hound_connection]),
        var!(meta[:hound_session_id]),
        url
      )
    end
  end


  @doc "Navigate forward in browser history"
  defmacro navigate_forward do
    quote do
      navigate_forward(var!(meta[:hound_connection]), var!(meta[:hound_session_id]))
    end
  end


  @doc "Navigate back in browser history"
  defmacro navigate_back do
    quote do
      navigate_back(var!(meta[:hound_connection]), var!(meta[:hound_session_id]))
    end
  end


  @doc "Refresh current page"
  defmacro refresh do
    quote do
      refresh(var!(meta[:hound_connection]), var!(meta[:hound_session_id]))
    end
  end

end
