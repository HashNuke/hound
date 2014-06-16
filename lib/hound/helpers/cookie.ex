defmodule Hound.Helpers.Cookie do
  @moduledoc "Provides cookie-related functions."

  import Hound.JsonDriver.Utils


  @doc """
  Gets cookies. Returns a list of ListDicts, each containing properties of the cookie.

      cookies()
  """
  @spec cookies() :: List.t
  def cookies() do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Cookie.cookies
  end


  @doc """
  Sets cookie.

      set_cookie([name: "cart_id", value: 123213])
      set_cookie([name: "cart_id", value: "23fa0ev5a6er", secure: true])

  Accepts a ListDict with the following keys:

  * name (string) - REQUIRED
  * value (string) - REQUIRED
  * path (string)
  * domain (string)
  * secure (boolean)
  * expiry (integer, specified in seconds since midnight, January 1, 1970 UTC)
  """
  @spec set_cookie(Dict.t) :: :ok
  def set_cookie(cookie) do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Cookie.set_cookie(cookie)
  end


  @doc "Delete all cookies"
  @spec delete_cookies() :: :ok
  def delete_cookies() do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Cookie.delete_cookies()
  end


  @doc "Delete a cookie with the given name"
  @spec delete_cookie(String.t) :: :ok
  def delete_cookie(name) do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Cookie.delete_cookie(name)
  end

end
