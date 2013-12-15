defmodule Hound.WindowBehaviour do
  use Behaviour

  @doc "Get all window handles available to the session"
  defcallback current_window_handle(session_id :: String.t) :: String.t

  @doc "Get list of window handles available to the session"
  defcallback window_handles(session_id :: String.t) :: List.t

# TODO
#   @doc "Change focus to frame"
#   defcallback focus_frame(session_id :: String.t, frame_identifier)

#   @doc "Change focus to another window"
#   defcallback focus_window(session_id :: String.t, window_identifier)

#   @doc "Close current window"
#   defcallback close_current_window(session_id :: String.t)

#   @doc "Change size of window"
#   defcallback set_window_size(session_id :: String.t, window_handle, size)

#   @doc "Get window size"
#   defcallback window_size(session_id :: String.t, window_handle)

#   @doc "Get window position"
#   defcallback window_position(session_id :: String.t, window_handle)

#   @doc "Set window position"
#   defcallback set_window_position(session_id :: String.t, window_handle, position)

#   @doc "Maximize window"
#   defcallback set_window_position(session_id :: String.t, window_handle)
end