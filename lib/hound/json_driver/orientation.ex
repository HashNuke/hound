defmodule Hound.JsonDriver.Orientation do
  @moduledoc "Provides function related to orientation."

  import Hound.JsonDriver.Utils

  @spec orientation() :: :landscape | :portrait
  def orientation() do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/orientation")
  end


  @spec set_orientation(:landscape | :portrait) :: :ok
  def set_orientation(orientation) do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/orientation", %{orientation: orientation})
  end
end
