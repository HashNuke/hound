defmodule HoundNotSupportedErrorTest do
  use ExUnit.Case

  test "message" do
    {:ok, info} = Hound.ConnectionServer.driver_info
    function_name = "foo"
    err = try do
            raise Hound.NotSupportedError, function: function_name
          rescue
            e -> Exception.message(e)
          end
    assert err =~ "not supported"
    assert err =~ function_name
    assert err =~ info.driver
    assert err =~ info.browser
  end
end
