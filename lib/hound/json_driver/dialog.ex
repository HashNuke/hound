defmodule Hound.JsonDriver.Dialog do
  import Hound.JsonDriver.Utils

  @doc "Get text of a javascript alert(), confirm() or prompt()"
  @spec dialog_text() :: String.t
  def dialog_text() do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/alert_text")
  end


  @doc "Send input to a javascript prompt()"
  @spec input_into_prompt(String.t) :: :ok 
  def input_into_prompt(input) do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/alert_text", [text: input])
  end


  @doc "Accept javascript dialog"
  @spec accept_dialog() :: :ok
  def accept_dialog() do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/accept_alert")
  end


  @doc "Dismiss javascript dialog"
  @spec dismiss_dialog() :: :ok
  def dismiss_dialog() do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/dismiss_alert", [])
  end

end
