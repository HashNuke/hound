defmodule Hound.Helpers.Dialog do
  @moduledoc "Functions to handle Javascript dialogs alert(), prompt() and confirm()"

  import Hound.RequestUtils

  @doc """
  Gets text of a javascript alert(), confirm() or prompt().

      dialog_text()
  """
  @spec dialog_text() :: String.t
  def dialog_text do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/alert_text")
  end


  @doc """
  Inputs text to a javascript prompt().

      input_into_prompt("John Doe")
  """
  @spec input_into_prompt(String.t) :: :ok
  def input_into_prompt(input) do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/alert_text", %{text: input})
  end


  @doc """
  Accepts javascript dialog.

      accept_dialog()
  """
  @spec accept_dialog() :: :ok
  def accept_dialog do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/accept_alert")
  end


  @doc """
  Dismiss a javascript dialog.

      dismiss_dialog()
  """
  @spec dismiss_dialog() :: :ok
  def dismiss_dialog do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/dismiss_alert", %{})
  end

end
