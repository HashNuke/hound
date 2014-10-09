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
  @spec set_window_size(String.t, integer, integer) :: :ok
  def set_window_size(window_handle, width, height) do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Window.set_window_size(window_handle, width, height)
  end

  @doc "Get size of the window"
  @spec window_size(String.t) :: tuple
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


  @doc "Focus frame"
  @spec focus_frame(any) :: :ok
  def focus_frame(frame_id) do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Window.focus_frame(frame_id)
  end


  @doc "Change focus to parent frame"
  @spec focus_parent_frame() :: :ok
  def focus_parent_frame() do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Window.focus_parent_frame()
  end
end
