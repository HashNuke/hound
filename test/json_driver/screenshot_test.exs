defmodule ScreenshotTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "should take a screenshot" do
    navigate_to("http://localhost:9090/page1.html")
    path = take_screenshot("screenshot-test.png")
    assert File.exists?(path)
  end

end
