defmodule Hound.JsonDriver.Cookie do
  @moduledoc "Provides cookie-related functions."

  import Hound.JsonDriver.Utils


  @spec cookies() :: List.t
  def cookies() do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/cookie")
  end


  @spec set_cookie(Dict.t) :: :ok
  def set_cookie(cookie) do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/cookie", %{cookie: cookie})
  end


  @spec delete_cookies() :: :ok
  def delete_cookies() do
    session_id = Hound.current_session_id
    make_req(:delete, "session/#{session_id}/cookie")
  end


  @spec delete_cookie(String.t) :: :ok
  def delete_cookie(name) do
    session_id = Hound.current_session_id
    make_req(:delete, "session/#{session_id}/cookie/#{name}")
  end
end
