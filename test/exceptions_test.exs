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

  defmodule DummyRaiser do
    require Hound.NotSupportedError

    def foo do
      Hound.NotSupportedError.raise_for(%{driver: "selenium", browser: "firefox"})
      :ok
    end
  end

  test "raise_for" do
    if match?({:ok, %{driver: "selenium", browser: "firefox"}}, Hound.ConnectionServer.driver_info) do
      assert_raise Hound.NotSupportedError, fn ->
        DummyRaiser.foo
      end
    else
      assert DummyRaiser.foo == :ok
    end
  end
end
