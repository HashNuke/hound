defmodule Hound.OrientationBehaviour do
  use Behaviour

  @doc "Get browser's orientation"
  defcallback orientation(session_id :: String.t) :: :landscape | :portrait

  @doc "Set browser's orientation"
  defcallback set_orientation(session_id :: String.t, orientation :: :landscape | :portrait) :: :ok
end