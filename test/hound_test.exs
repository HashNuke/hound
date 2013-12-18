defmodule HoundTest do
  use ExUnit.Case
  use Hound.ExUnitHelpers

  hound_session

  test "the truth", meta do
    navigate_to "http://google.com"
    assert(true)
  end
end
