defmodule Hound.PageBehaviour do
  use Behaviour

  @doc "Get source of current page"
  defcallback source(session_id :: String.t) :: String.t

  @doc "Get the title of the current page"
  defcallback title(session_id :: String.t) :: String.t

  @doc "Find element on current page"
  defcallback find(session_id :: String.t, strategy :: String.t, selector :: String.t)

  @doc "Find elements on current page"
  defcallback find_all(session_id :: String.t, strategy :: atom, selector :: String.t) :: List.t

  @doc "Find element within element"
  defcallback find_within_element(session_id :: String.t, strategy :: atom, selector :: String.t) :: Dict.t

  @doc "Find elements within element"
  defcallback find_all_within_element(session_id :: String.t, strategy :: atom, selector :: String.t) :: List.t

  @doc "Get element on page currently in focus"
  defcallback element_in_focus(session_id :: String.t) :: Dict.t

  @doc "Click on element"
  defcallback click_on(session_id :: String.t, element_identifier :: String.t) :: :ok

  @doc "Submit form"
  defcallback submit(session_id :: String.t, element_identifier :: String.t) :: :ok

  @doc "Send sequence of key strokes to active element. The modifier keys are not released after this command is run."
  defcallback send_keys(session_id :: String.t, keys :: List.t) :: :ok
end