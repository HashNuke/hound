defmodule Hound.JsonDriver.Cookie do
  import Hound.JsonDriver.Utils

  @doc "Get cookies"
  @spec cookies() :: List.t
  def cookies() do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/cookie")
  end

  @doc "Set cookie"
  @spec set_cookie(String.t) :: :ok
  def set_cookie(cookie) do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/cookie", [cookie: cookie])
  end

  @doc "Delete all cookies"
  @spec delete_cookies() :: :ok
  def delete_cookies() do
    session_id = Hound.get_current_session_id
    make_req(:delete, "session/#{session_id}/cookie")
  end

  @doc "Delete a cookie with the given name"
  @spec delete_cookie(String.t) :: :ok
  def delete_cookie(name) do
    session_id = Hound.get_current_session_id
    make_req(:delete, "session/#{session_id}/cookie/#{name}")
  end
end
