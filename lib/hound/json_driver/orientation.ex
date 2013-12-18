defmodule Hound.Behaviours.Orientation do
  import Hound.JsonDriver.Utils

  @doc "Get browser's orientation"
  @spec orientation(Dict.t, String.t) :: :landscape | :portrait
  def orientation(connection, session_id :: String.t) do
    make_req(connection, :get, "/sessions/#{session_id}/orientation")
  end


  @doc "Set browser's orientation"
  @spec set_orientation(String.t, :landscape | :portrait) :: :ok
  def set_orientation(connection, session_id, orientation) do
    make_req(connection, :get, "/sessions/#{session_id}/orientation", [orientation: orientation])
  end
end