defmodule Hound.JsonDriver.Session do
  import Hound.JsonDriver.Utils

  @doc "Get server's current status"
  @spec server_status(Dict.t) :: Dict.t
  def server_status(connection) do
    make_req(connection, :get, "status")
  end


  @doc "Get list of active sessions"
  @spec active_sessions(Dict.t) :: Dict.t
  def active_sessions(connection) do
    make_req(connection, :get, "sessions")
  end


  @doc "Create a session"
  @spec create_session(Dict.t) :: String.t
  def create_session(connection) do
    params = [
      desiredCapabilities: [
        javascriptEnabled: false,
        version: "",
        rotatable: false,
        takesScreenshot: true,
        cssSelectorsEnabled: true,
        browserName: "firefox",
        nativeEvents: false,
        platform: "ANY"
      ]
    ]
    make_req(connection, :post, "session", params)
  end


  @doc "Get capabilities of a particular session"
  @spec session_info(Dict.t, String.t) :: Dict.t
  def session_info(connection, session_id) do
    make_req(connection, :get, "sessions/#{session_id}")
  end


  @doc "Delete a session"
  @spec delete_session(Dict.t, String.t) :: :ok
  def delete_session(connection, session_id) do
    make_req(connection, :delete, "sessions/#{session_id}")
  end


  @doc "Set the timeout for a particular type of operation"
  @spec set_timeout(Dict.t, String.t, String.t, Integer.t) :: :ok
  def set_timeout(connection, session_id, operation, time) do
    make_req(connection, :post, "sessions/#{session_id}/timeouts", [type: operation, ms: time])
  end
end
