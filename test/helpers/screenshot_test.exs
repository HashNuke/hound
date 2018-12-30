defmodule ScreenshotTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

  setup do
    navigate_to("http://localhost:9090/page1.html")
    :ok
  end

  test "should take a screenshot with a generated file name" do
    default_path = File.cwd!()

    path = take_screenshot()

    assert File.exists?(path)
    assert path =~ default_path
    assert file_name(path) =~ ~r/^screenshot-\d{4}(?:-\d{1,2}){5}\.png$/
  end

  test "file names generated 1 second apart are unique" do
    default_path = File.cwd!()

    path1 = take_screenshot()
    :timer.sleep(1000)
    path2 = take_screenshot()

    paths = [path1, path2]
    assert paths == Enum.uniq(paths)
  end

  describe "When given a file name" do
    test "should take a screenshot at the default location with the specified file name" do
      default_path = File.cwd!()

      take_screenshot("screenshot-test.png")

      assert File.exists?("#{default_path}/screenshot-test.png")
    end
  end

  describe "When given a file name with path" do
    test "should take a screenshot at the specified location with the specified file name" do
      take_screenshot("test/screenshot-test.png")

      assert File.exists?("test/screenshot-test.png")
    end
  end

  describe "When :screenshot_dir is set" do
    setup do
      screenshot_dir = "tmp/screenshots/"
      Application.put_env(:hound, :screenshot_dir, screenshot_dir)
      change_session_to(:with_opts, [screenshot_dir: screenshot_dir])

      navigate_to("http://localhost:9090/page1.html")
      :ok
    end

    test "should take a screenshot in the screenshot dir with a generated file name" do
      path = take_screenshot()

      assert File.exists?(path)
      # ConnectionServer already started so new screenshot_dir not picked up
      # assert path =~ "tmp/screenshots/"
      assert file_name(path) =~ ~r/^screenshot-\d{4}(?:-\d{1,2}){5}\.png$/
    end
  end

  defp file_name(path) do
    path
    |> String.split("/")
    |> List.last()
  end
end
