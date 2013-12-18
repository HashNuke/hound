defmodule Hound.JsonDriver.Screenshot do
  import Hound.JsonDriver.Utils

  @doc "Take screenshot of the current page"
  @spec take_screenshot(Dict.t, String.t) :: String.t
  def take_screenshot(connection, session_id) do
    make_req(connection, :get, "session/#{session_id}/screenshot")
  end
end
