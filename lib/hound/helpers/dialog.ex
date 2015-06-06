defmodule Hound.Helpers.Dialog do
  @moduledoc "Provides functions to handle Javascript dialogs alert(), prompt() and confirm()."

  import Hound.InternalHelpers

  @doc """
  Gets text of a javascript alert(), confirm() or prompt().

      dialog_text()
  """
  @spec dialog_text() :: String.t
  def dialog_text do
    {:ok, driver_info} = Hound.driver_info
    delegate_to_module driver_info[:driver_type], "Dialog", :dialog_text
  end


  @doc """
  Inputs text to a javascript prompt().

      input_into_prompt("John Doe")
  """
  @spec input_into_prompt(String.t) :: :ok
  def input_into_prompt(input) do
    {:ok, driver_info} = Hound.driver_info
    delegate_to_module driver_info[:driver_type], "Dialog", :input_into_prompt, [input]
  end


  @doc """
  Accepts javascript dialog.

      accept_dialog()
  """
  @spec accept_dialog() :: :ok
  def accept_dialog do
    {:ok, driver_info} = Hound.driver_info
    delegate_to_module driver_info[:driver_type], "Dialog", :accept_dialog
  end


  @doc """
  Dismiss a javascript dialog.

      dismiss_dialog()
  """
  @spec dismiss_dialog() :: :ok
  def dismiss_dialog do
    {:ok, driver_info} = Hound.driver_info
    delegate_to_module driver_info[:driver_type], "Dialog", :dismiss_dialog
  end

end
