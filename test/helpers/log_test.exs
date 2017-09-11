defmodule LogTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

  test "Should be able to extract log written in javascript" do
    navigate_to "http://localhost:9090/page1.html"

    execute_script("console.log(\"Some log\");")
    execute_script("console.log(\"Next log\");")

    if is_webdriver_selenium() do
      assert_raise Hound.NotSupportedError, "fetch_log() is not supported by driver selenium with browser firefox", fn ->
        fetch_log()
      end
    else
      log = fetch_log()

      assert log =~ "Some log"
      assert log =~ "Next log"
    end
  end

  test "Should be able to detect if theres any errors in the javascript" do
    navigate_to "http://localhost:9090/page_with_javascript_error.html"
    execute_script("console.log(\"Should not return normal logs\");")

    if is_webdriver_selenium() do
      assert_raise Hound.NotSupportedError, "fetch_errors() is not supported by driver selenium with browser firefox", fn ->
        fetch_errors()
      end
    else
      log = fetch_errors()
      refute log =~ "Should not return normal logs"
      assert log =~ "This is a javascript error"
    end
  end

  defp is_webdriver_selenium() do
    match?({:ok, %{driver: "selenium"}}, Hound.driver_info)
  end
end
