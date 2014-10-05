defmodule Hound.Helpers.Window do

  @doc "Get all window handles available to the session"
  @spec current_window_handle() :: String.t
  def current_window_handle do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Window.current_window_handle
  end

  @doc "Get list of window handles available to the session"
  @spec window_handles() :: List.t
  def window_handles do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Window.window_handles
  end

  @doc "Change size of the window"
  @spec set_window_size(String.t,Dict.t) :: :ok
  def set_window_size(window_handle, size) do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Window.set_window_size(window_handle, size)
  end

  @doc "Get size of the window"
  @spec window_size(String.t) :: Dict.t
  def window_size(window_handle) do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Window.window_size(window_handle)
  end

  @doc "Maximize the window"
  @spec maximize_window(String.t) :: :ok
  def maximize_window(window_handle) do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Window.maximize_window(window_handle)
  end

end
