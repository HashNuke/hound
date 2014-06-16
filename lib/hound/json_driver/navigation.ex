defmodule Hound.JsonDriver.Navigation do
  @moduledoc "Provides navigation functions."

  import Hound.JsonDriver.Utils

  @spec current_url() :: String.t
  def current_url do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/url")
  end


  @spec navigate_to(String.t) :: :ok
  def navigate_to(url) do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/url", [url: url])
  end


  @spec navigate_forward() :: :ok
  def navigate_forward do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/forward")
  end


  @spec navigate_back() :: :ok
  def navigate_back do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/back")
  end


  @spec refresh_page() :: :ok
  def refresh_page do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/refresh")
  end

end
