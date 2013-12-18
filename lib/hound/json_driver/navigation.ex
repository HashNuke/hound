defmodule Hound.JsonDriver.Navigation do
  import Hound.JsonDriver.Utils

  @doc "Get url of the current page"
  @spec current_url(Dict.t, String.t) :: String.t
  def current_url(connection, session_id) do
    make_req(connection, :get, "/sessions/#{session_id}/url")
  end


  @doc "Navigate to a url"
  @spec navigate_to(Dict.t, String.t, String.t) :: :ok
  def navigate_to(connection, session_id, url) do
    make_req(connection, :post, "/sessions/#{session_id}/url")
  end


  @doc "Navigate forward in browser history"
  @spec navigate_forward(Dict.t, String.t) :: :ok
  def navigate_forward(connection, session_id) do
    make_req(connection, :post, "/sessions/#{session_id}/forward")
  end


  @doc "Navigate back in browser history"
  @spec navigate_back(Dict.t, String.t) :: :ok
  def navigate_back(connection, session_id) do
    make_req(connection, :post, "/sessions/#{session_id}/back")
  end


  @doc "Refresh current page"
  @spec refresh(Dict.t, String.t) :: :ok
  def refresh(connection, session_id) do
    make_req(connection, :post, "/sessions/#{session_id}/refresh")
  end

end
