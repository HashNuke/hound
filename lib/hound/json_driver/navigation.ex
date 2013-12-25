defmodule Hound.JsonDriver.Navigation do
  @moduledoc "Provides navigation functions."

  import Hound.JsonDriver.Utils

  @doc "Gets url of the current page."
  @spec current_url() :: String.t
  def current_url do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/url")
  end


  @doc """
  Navigates to a url.

      navigate_to("http://example.com")
  """
  @spec navigate_to(String.t) :: :ok
  def navigate_to(url) do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/url", [url: url])
  end


  @doc "Navigates forward in browser history."
  @spec navigate_forward() :: :ok
  def navigate_forward do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/forward")
  end


  @doc "Navigates back in browser history."
  @spec navigate_back() :: :ok
  def navigate_back do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/back")
  end


  @doc "Refreshes the current page."
  @spec refresh_page() :: :ok
  def refresh_page do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/refresh")
  end

end
