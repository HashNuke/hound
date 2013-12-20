defmodule HoundTest do
  use ExUnit.Case
  use Hound.Helpers

  setup do
    Hound.start_session
    :ok
  end

  test "the truth" do
    navigate_to "http://google.com"
    assert(true)
  end

  teardown do
    Hound.end_session
    :ok
  end
end
