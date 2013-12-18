defmodule Hound.ExUnitHelpers.Session do


  defmacro hound_session(name // :default) do
    quote do
      setup do
        { connection, session_id } = :gen_server.call(:hound, {:get_session, unquote(name)})
        { :ok, hound_connection: connection, hound_session_id: session_id }
      end
    end
  end


  @doc "Get capabilities of a particular session"
  defmacro session do
    quote do
      session(var!(meta[:hound_connection]), var!(meta[:hound_session_id]))
    end
  end


  @doc "Set the timeout for a particular type of operation"
  defmacro set_timeout(operation, time) do
    quote do
      set_timeout(var!(meta[:hound_connection]), var!(meta[:hound_session_id]), operation, time)
    end
  end

end
