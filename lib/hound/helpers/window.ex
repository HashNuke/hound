defmodule Hound.Helpers.Window do

  @doc "Get all window handles available to the session"
  @spec current_window_handle() :: String.t
  def current_window_handle do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].current_window_handle
  end

  @doc "Get list of window handles available to the session"
  @spec window_handles() :: List.t
  def window_handles do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].window_handles
  end

end
