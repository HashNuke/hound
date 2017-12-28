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

    file_name =
      path
      |> String.split("/")
      |> List.last()

    assert path =~ default_path
    assert file_name =~ ~r/^screenshot-\d{4}(?:-\d{1,2}){5}\.png$/
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

end
