defmodule Hound.JsonDriver.Window do
  import Hound.JsonDriver.Utils

  @doc "Get all window handles available to the session"
  @spec current_window_handle() :: String.t
  def current_window_handle() do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/window_handle")
  end

  @doc "Get list of window handles available to the session"
  @spec window_handles() :: List.t
  def window_handles() do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/window_handles")
  end

# TODO
#   @doc "Change focus to frame"
#   @spec focus_frame(Dict.t, String.t, String.t) :: :ok
#   def focus_frame(connection, session_id :: String.t, frame_id) do
#   end

#   @doc "Change focus to another window"
#   def focus_window(connection, session_id :: String.t, window_identifier) do
#   end

#   @doc "Close current window"
#   def close_current_window(connection, session_id :: String.t) do
#   end

#   @doc "Change size of window"
#   def set_window_size(connection, session_id :: String.t, window_handle, size) do
#   end

#   @doc "Get window size"
#   def window_size(connection, session_id :: String.t, window_handle) do
#   end

#   @doc "Get window position"
#   def window_position(connection, session_id :: String.t, window_handle) do
#   end

#   @doc "Set window position"
#   def set_window_position(connection, session_id :: String.t, window_handle, position) do
#   end

#   @doc "Maximize window"
#   def set_window_position(connection, session_id :: String.t, window_handle) do
#   end
end