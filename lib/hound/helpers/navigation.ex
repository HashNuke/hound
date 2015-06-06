defmodule Hound.Helpers.Navigation do
  @moduledoc "Provides navigation functions."

  import Hound.InternalHelpers
  import Hound.RequestUtils

  @doc "Gets url of the current page."
  @spec current_url :: String.t
  def current_url do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/url")
  end


  @doc """
  Navigates to a url or relative path.

      navigate_to("http://example.com/page1")
      navigate_to("/page1")
  """
  @spec navigate_to(String.t) :: :ok
  def navigate_to(url) do
    final_url = generate_final_url(url)
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/url", %{url: final_url})
  end


  @doc "Navigates forward in browser history."
  @spec navigate_forward :: :ok
  def navigate_forward do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/forward")
  end


  @doc "Navigates back in browser history."
  @spec navigate_back() :: :ok
  def navigate_back do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/back")
  end


  @doc "Refreshes the current page."
  @spec refresh_page() :: :ok
  def refresh_page do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/refresh")
  end


  defp generate_final_url(url) do
    {:ok, configs} = Hound.configs

    if relative_path?(url) do
      "#{configs[:host]}:#{configs[:port]}#{url}"
    else
      url
    end
  end

  defp relative_path?(url) do
    String.starts_with?(url, "/")
  end

end
