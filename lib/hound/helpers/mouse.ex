defmodule Hound.Helpers.Mouse do
  @moduledoc "Functions to work with the mouse"

  import Hound.RequestUtils

  @doc """
  Triggers a mousedown event on the current position of the mouse, which can be set through `Helpers.Element.move_to/3`.
  The mousedown event can get triggered with three different "buttons":
    1. Primary Button = 0 which is the default (in general, the left button)
    2. Auxiliary Button = 1 (in general, the middle button)
    3. Secondary Button = 2 (in general, the right button)

      mouse_down()
  """
  @spec mouse_down(integer) :: :ok
  def mouse_down(button \\ 0) do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/buttondown", %{button: button})
  end


  @doc """
  Triggers a mouseup event on the current position of the mouse, which can be set through `Helpers.Element.move_to/3`.
  The mouseup event can get triggered with three different "buttons":
    1. Primary Button = 0 which is the default (in general, the left button)
    2. Auxiliary Button = 1 (in general, the middle button)
    3. Secondary Button = 2 (in general, the right button)

      mouse_up()
  """
  @spec mouse_up(integer) :: :ok
  def mouse_up(button \\ 0) do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/buttonup", %{button: button})
  end
end
