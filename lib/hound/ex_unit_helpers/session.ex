defmodule Hound.ExUnitHelpers.Session do

  @doc """
  Adds ExUnit setup callback to create session and teardown callback to destroy session.

  On creation of the session, you will have the hound connection information and session ID
  available in the `meta` variable that ex_unit provides.

  You can access it with the following:

  * Session ID - `meta[:hound_session_id]`
  * Connection information - `meta[:hound_connection]`

  __Both these are internal and must not be altered.__
  If you like to start another session, then you might want to use the connection information.
  Sessions started manually are not managed by Hound's inbuilt webdriver session server.
  """
  defmacro hound_session do
    quote do
      setup do
        { connection, session_id } = :gen_server.call(:hound, {:get_session, :default})
        { :ok, hound_connection: connection, hound_session_id: session_id }
      end
    end
  end


  @doc "Get capabilities of the current session"
  defmacro session_info do
    quote do
      session_info(var!(meta[:hound_connection]), var!(meta[:hound_session_id]))
    end
  end


  @doc "Set the timeout for a particular type of operation"
  defmacro set_timeout(operation, time) do
    quote do
      set_timeout(var!(meta[:hound_connection]), var!(meta[:hound_session_id]), operation, time)
    end
  end

end
