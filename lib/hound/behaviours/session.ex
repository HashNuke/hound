defmodule Hound.Behaviours.Session do
  use Behaviour

  @doc "Get server's current status"
  defcallback server_status() :: Dict.t

  @doc "Get list of active sessions"
  defcallback active_sessions() :: Dict.t

  @doc "Create a session"
  defcallback create_session() :: String.t

  @doc "Get capabilities of a particular session"
  defcallback session(session_id :: String.t) :: Dict.t

  @doc "Delete a session"
  defcallback delete_session(session_id :: String.t) :: :ok

  @doc "Set the timeout for a particular type of operation"
  defcallback set_timeout(session_id :: String.t, operation :: String.t, time :: Integer.t) :: :ok
end
