defmodule HoundTest do
  use ExUnit.Case
  use Hound.ExUnitHelpers

  hound_session

  test "the truth", meta do
    assert(true)
  end
end
