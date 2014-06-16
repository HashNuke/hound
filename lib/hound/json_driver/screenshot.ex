defmodule Hound.JsonDriver.Screenshot do
  import Hound.JsonDriver.Utils

  @doc """
  Takes screenshot of the current page. The screenshot is saved in the current working directory.
  It returns the path of the png file, to which the screenshot has been saved.

  For Elixir mix projects, the saved screenshot can be found in the root of the project directory.

      take_screenshot()

  You can also pass a file path to which the screenshot must be saved to.

      # Pass a full file path
      take_screenshot("/media/screenshots/test.png")

      # Or you can also pass a path relative to the current directory.
      take_screenshot("screenshot-test.png")
  """
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
