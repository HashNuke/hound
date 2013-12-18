defmodule Hound.Helpers.Session do

  @doc "Get capabilities of a particular session"
  defmacro session do
    quote do
      session(var!(meta[:hound_connection]), var!(meta[:hound_session_id]))
    end
  end


  @doc "Delete a session"
  defmacro delete_session do
    quote do
      delete_session(var!(meta[:hound_connection]), var!(meta[:hound_session_id]))
    end
  end


  @doc "Set the timeout for a particular type of operation"
  defmacro set_timeout(operation, time) do
    quote do
      set_timeout(var!(meta[:hound_connection]), var!(meta[:hound_session_id]), operation, time)
    end
  end

end
