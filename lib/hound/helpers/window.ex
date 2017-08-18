defmodule Hound.Helpers.Window do
  @moduledoc "Window size and other window-related functions"

  import Hound.RequestUtils

  @doc "Get all window handles available to the session"
  @spec current_window_handle() :: String.t
  def current_window_handle do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/window_handle")
  end

  @doc "Get list of window handles available to the session"
  @spec window_handles() :: list
  def window_handles do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/window_handles")
  end

  @doc "Change size of the window"
  @spec set_window_size(String.t, integer, integer) :: :ok
  def set_window_size(window_handle, width, height) do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/window/#{window_handle}/size", %{width: width, height: height})
  end

  @doc "Get size of the window"
  @spec window_size(String.t) :: tuple
  def window_size(window_handle) do
    session_id = Hound.current_session_id
    size = make_req(:get, "session/#{session_id}/window/#{window_handle}/size")
    {Map.get(size, "width"), Map.get(size, "height")}
  end

  @doc "Maximize the window"
  @spec maximize_window(String.t) :: :ok
  def maximize_window(window_handle) do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/window/#{window_handle}/maximize")
  end

  @doc "Focus the window"
  @spec focus_window(String.t) :: nil
  def focus_window(window_handle) do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/window", %{handle: window_handle, name: window_handle})
  end

  @doc "Close the current window"
  @spec close_current_window :: nil
  def close_current_window do
    session_id = Hound.current_session_id
    make_req(:delete, "session/#{session_id}/window")
  end

  @doc """
  Set the focus to a specific frame, such as an iframe

  ## Example

      iex> iframe = find_element(:id, "id-of-some-iframe")
      iex> focus_frame(iframe)
      nil
  """
  @spec focus_frame(any) :: :ok
  def focus_frame(frame_id) do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/frame", %{id: frame_id})
  end


  @doc "Change focus to parent frame"
  @spec focus_parent_frame() :: :ok
  def focus_parent_frame() do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/frame/parent")
  end


  # TODO
  #   @doc "Get window position"
  #   def window_position(window_handle) do
  #   end

  #   @doc "Set window position"
  #   def set_window_position(window_handle, position) do
  #   end
end
