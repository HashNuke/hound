defmodule WindowTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

  test "should set and get the window size" do
    set_window_size current_window_handle(), 600, 400
    {width, height} = window_size(current_window_handle())
    assert width  == 600
    assert height == 400
  end


  test "should maximize the window" do
    set_window_size current_window_handle(), 0, 0
    {width, height} = window_size(current_window_handle())
    assert width  > 0
    assert height > 0
  end


  test "switch to a frame" do
    navigate_to "http://localhost:9090/page1.html"
    assert length(find_all_elements :class, "child-para") == 0

    focus_frame(0)
    assert length(find_all_elements :class, "child-para") > 0
  end

  test "focus window" do
    navigate_to "http://localhost:9090/page1.html"
    assert Enum.count(window_handles()) == 1
    execute_script("window.open('http://localhost:9090/page2.html')", [])
    assert Enum.count(window_handles()) == 2
    window_handles() |> Enum.at(1) |> focus_window()
    assert current_url() == "http://localhost:9090/page2.html"
    window_handles() |> Enum.at(0) |> focus_window()
    assert current_url() == "http://localhost:9090/page1.html"
  end

  test "close window" do
    navigate_to "http://localhost:9090/page1.html"
    assert Enum.count(window_handles()) == 1
    execute_script("window.open('http://localhost:9090/page2.html')", [])
    assert Enum.count(window_handles()) == 2
    window_handles() |> Enum.at(1) |> focus_window()
    close_current_window()
    window_handles() |> Enum.at(0) |> focus_window()
    assert Enum.count(window_handles()) == 1
    assert current_url() == "http://localhost:9090/page1.html"
  end

  if Hound.InternalHelpers.driver_supports?("focus_parent_frame") do
    test "switch to a frame and switch back to parent frame" do
      navigate_to "http://localhost:9090/page1.html"
      assert length(find_all_elements :class, "child-para") == 0

      focus_frame(0)
      assert length(find_all_elements :class, "child-para") > 0

      focus_parent_frame()
      assert length(find_all_elements :class, "child-para") == 0
    end
  end
end
