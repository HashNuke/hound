defmodule Hound.JsonDriver.Orientation do
  @moduledoc "Provides function related to orientation."

  import Hound.JsonDriver.Utils

  @doc """Gets browser's orientation. Will return either `:landscape` or `:portrait`"""
  @spec orientation() :: :landscape | :portrait
  def orientation() do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/orientation")
  end


  @doc """Sets browser's orientation. Pass either `:landscape` or `:portrait`"""
  @spec set_orientation(:landscape | :portrait) :: :ok
  def set_orientation(orientation) do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/orientation", [orientation: orientation])
  end
end