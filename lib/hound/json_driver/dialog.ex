defmodule Hound.JsonDriver.Dialog do
  @moduledoc "Provides functions to handle Javascript dialogs alert(), prompt() and confirm()."

  import Hound.JsonDriver.Utils

  @spec dialog_text() :: String.t
  def dialog_text() do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/alert_text")
  end


  @spec input_into_prompt(String.t) :: :ok
  def input_into_prompt(input) do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/alert_text", %{text: input})
  end


  @spec accept_dialog() :: :ok
  def accept_dialog() do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/accept_alert")
  end


  @spec dismiss_dialog() :: :ok
  def dismiss_dialog() do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/dismiss_alert", %{})
  end

end
