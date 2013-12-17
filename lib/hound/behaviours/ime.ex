defmodule Hound.Behaviours.Ime do
  use Behaviour

  @doc "List available IME engines"
  defcallback available_ime_engines(session_id :: String.t) :: Dict.t

  @doc "Get name of active IME engine"
  defcallback active_ime_engine(session_id :: String.t) :: String.t

  @doc "Checks if the IME input is currently active"
  defcallback ime_active?(session_id :: String.t) :: Boolean.t

  @doc "Activate IME engine"
  defcallback activate_ime_engine(session_id :: String.t, engine_name :: String.t) :: :ok

  @doc "Deactivate currently active IME engine"
  defcallback deactivate_current_ime_engine(session_id :: String.t) :: :ok
end
