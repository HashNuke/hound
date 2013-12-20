defmodule Hound.JsonDriver.Screenshot do
  import Hound.JsonDriver.Utils

  @doc "Take screenshot of the current page"
  @spec take_screenshot() :: String.t
  def take_screenshot() do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/screenshot")
  end
end
