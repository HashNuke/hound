defmodule Hound.DialogBehaviour do
  use Behaviour

  @doc "Get text of a javascript alert(), confirm() or prompt()"
  defcallback dialog_text(session_id :: String.t) :: String.t

  @doc "Send input to a javascript prompt()"
  defcallback input_into_prompt(session_id :: String.t, input :: String.t) :: :ok

  @doc "Accept javascript dialog"
  defcallback accept_dialog(session_id :: String.t) :: :ok

  @doc "Dismiss javascript dialog"
  defcallback dismiss_dialog(session_id :: String.t) :: :ok
end
