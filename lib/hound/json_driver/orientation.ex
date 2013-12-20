defmodule Hound.JsonDriver.Orientation do
  import Hound.JsonDriver.Utils

  @doc "Get browser's orientation"
  @spec orientation() :: :landscape | :portrait
  def orientation() do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/orientation")
  end


  @doc "Set browser's orientation"
  @spec set_orientation(:landscape | :portrait) :: :ok
  def set_orientation(orientation) do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/orientation", [orientation: orientation])
  end
end