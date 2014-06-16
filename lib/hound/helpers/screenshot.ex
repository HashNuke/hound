defmodule Hound.Helpers.Screenshot do

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
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Screenshot.take_screenshot(path)
  end

end
