defmodule Hound.JsonDriver.Navigation do
  import Hound.JsonDriver.Utils

  @doc "Get url of the current page"
  @spec current_url() :: String.t
  def current_url do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/url")
  end


  @doc "Navigate to a url"
  @spec navigate_to(String.t) :: :ok
  def navigate_to(url) do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/url", [url: url])
  end


  @doc "Navigate forward in browser history"
  @spec navigate_forward() :: :ok
  def navigate_forward do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/forward")
  end


  @doc "Navigate back in browser history"
  @spec navigate_back() :: :ok
  def navigate_back do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/back")
  end


  @doc "Refresh current page"
  @spec refresh() :: :ok
  def refresh do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/refresh")
  end

end
