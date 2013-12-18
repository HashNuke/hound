defmodule Hound.JsonDriver.Dialog do
  import Hound.JsonDriver.Utils

  @doc "Get text of a javascript alert(), confirm() or prompt()"
  @spec dialog_text(Dict.t, String.t) :: String.t
  def dialog_text(connection, session_id) do
    make_req(connection, :get, "/session/#{session_id}/alert_text")
  end


  @doc "Send input to a javascript prompt()"
  @spec input_into_prompt(Dict.t, String.t, String.t) :: :ok 
  def input_into_prompt(connection, session_id, input) do
    make_req(connection, :post, "/session/#{session_id}/alert_text", [text: input])
  end


  @doc "Accept javascript dialog"
  @spec accept_dialog(Dict.t, String.t) :: :ok
  def accept_dialog(connection, session_id) do
    make_req(connection, :post, "/session/#{session_id}/accept_alert")
  end


  @doc "Dismiss javascript dialog"
  @spec dismiss_dialog(Dict.t, String.t) :: :ok
  def dismiss_dialog(connection, session_id) do
    make_req(connection, :post, "/session/#{session_id}/dismiss_alert", [])
  end

end
