defmodule WindowTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "should set and get the window size" do
    set_window_size current_window_handle, %{height: 400, width: 200}
    assert window_size(current_window_handle) == %{"height" => 400, "width" => 200}
  end

  test "should maximize the window" do
    set_window_size current_window_handle, %{height: 0, width: 0}
    %{"height" => height, "width" => width} = window_size(current_window_handle)
    assert height > 0
    assert width > 0
  end

end
