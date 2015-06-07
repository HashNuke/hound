defmodule Hound.Helpers.Orientation do
  @moduledoc "Functions related to orientation"

  import Hound.RequestUtils

  @doc """
  Gets browser's orientation. Will return either `:landscape` or `:portrait`.
  """
  @spec orientation() :: :landscape | :portrait
  def orientation do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/orientation")
  end


  @doc """
  Sets browser's orientation.

  `:landscape` or `:portrait` are valid values for the first argument.

      set_orientation(:landscape)
      set_orientation(:portrait)
  """
  @spec set_orientation(:landscape | :portrait) :: :ok
  def set_orientation(orientation) do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/orientation", %{orientation: orientation})
  end
end
