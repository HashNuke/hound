defmodule WindowTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "should set and get the window size" do
    set_window_size current_window_handle, 600, 400
    {width, height} = window_size(current_window_handle)
    assert width  == 600
    assert height == 400
  end


  test "should maximize the window" do
    set_window_size current_window_handle, 0, 0
    {width, height} = window_size(current_window_handle)
    assert width  > 0
    assert height > 0
  end


  test "switch to a frame" do
    navigate_to "http://localhost:9090/page1.html"
    assert length(find_all_elements :class, "child-para") == 0

    focus_frame(0)
    assert length(find_all_elements :class, "child-para") > 0
  end


  test "switch to a frame and switch back to parent frame" do
    navigate_to "http://localhost:9090/page1.html"
    assert length(find_all_elements :class, "child-para") == 0

    focus_frame(0)
    assert length(find_all_elements :class, "child-para") > 0

    focus_parent_frame()
    assert length(find_all_elements :class, "child-para") == 0
  end
end
