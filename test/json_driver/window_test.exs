defmodule WindowTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "should set and get the window size" do
    set_window_size current_window_handle, %{"height" => 600, "width" => 400}
    %{"height" => height, "width" => width} = window_size(current_window_handle)
    assert height == 600
    assert width == 400
  end

  test "should maximize the window" do
    set_window_size current_window_handle, %{height: 0, width: 0}
    %{"height" => height, "width" => width} = window_size(current_window_handle)
    assert height > 0
    assert width > 0
  end

end
