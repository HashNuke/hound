defmodule Hound.JsonDriver.Screenshot do
  import Hound.JsonDriver.Utils

  @spec take_screenshot(String.t) :: String.t
  def take_screenshot(path \\ nil) do
    session_id = Hound.current_session_id
    base64_png_data = make_req(:get, "session/#{session_id}/screenshot")

    binary_image_data = :base64.decode(base64_png_data)
    {hour, minutes, seconds} = :erlang.time()
    {year, month, day} = :erlang.date()

    if !path do
      cwd = File.cwd!()
      path = "#{cwd}/screenshot-#{year}-#{month}-#{day}-#{hour}-#{minutes}-#{seconds}.png"
    end
    :ok = File.write path, binary_image_data
    path
  end
end
