defmodule ScriptExecutionTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "Execute javascript synchronously" do
    navigate_to "http://localhost:9090/page1.html"
    assert execute_script("return(arguments[0] + arguments[1]);", [1, 2]) == 3
  end


  test "Execute javascript asynchronously" do
    navigate_to "http://localhost:9090/page1.html"
    assert execute_script_async("arguments[arguments.length-1]('hello')", []) == "hello"
  end
end
