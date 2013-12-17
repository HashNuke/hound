defmodule Hound.Behaviours.Navigation do
  use Behaviour

  @doc "Get url of the current page"
  defcallback current_url(session_id :: String.t) :: String.t

  @doc "Navigate to a url"
  defcallback navigate_to(session_id :: String.t, url :: String.t) :: :ok

  @doc "Navigate forward in browser history"
  defcallback navigate_forward(session_id :: String.t) :: :ok

  @doc "Navigate back in browser history"
  defcallback navigate_back(session_id :: String.t) :: :ok

  @doc "Refresh current page"
  defcallback refresh(session_id :: String.t) :: :ok
end
