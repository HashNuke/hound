defmodule Hound.Helpers.Orientation do
  @moduledoc "Provides function related to orientation."

  @doc """
  Gets browser's orientation. Will return either `:landscape` or `:portrait`.
  """
  @spec orientation() :: :landscape | :portrait
  def orientation do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Orientation.orientation
  end


  @doc """
  Sets browser's orientation.

  `:landscape` or `:portrait` are valid values for the first argument.

      set_orientation(:landscape)
      set_orientation(:portrait)
  """
  @spec set_orientation(:landscape | :portrait) :: :ok
  def set_orientation(orientation) do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Orientation.set_orientation(orientation)
  end
end
