defmodule DialogTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "Get dialog text" do
    if Hound.InternalHelpers.driver_supports?("dialog_text") do
      navigate_to "http://localhost:9090/page1.html"
      execute_script("alert('hello')")
      assert dialog_text() == "hello"
    else
      assert true
    end
  end


  test "Dismiss dialog" do
    if Hound.InternalHelpers.driver_supports?("dismiss_dialog") do
      navigate_to "http://localhost:9090/page1.html"
      execute_script("return window.isItReal = confirm('Is it true?')")
      dismiss_dialog()
      assert execute_script("return window.isItReal") == false
    else
      assert true
    end
  end


  test "Accept dialog" do
    if Hound.InternalHelpers.driver_supports?("accept_dialog") do
      navigate_to "http://localhost:9090/page1.html"
      execute_script("return window.isItReal = confirm('Is it true?')")
      accept_dialog()
      assert execute_script("return window.isItReal") == true
    else
      assert true
    end
  end


  test "Input into prompt" do
    if Hound.InternalHelpers.driver_supports?("input_into_prompt") do
      navigate_to "http://localhost:9090/page1.html"
      execute_script("return window.isItReal = prompt('Is it true?')")
      input_into_prompt("Yes it is")
      accept_dialog()
      assert execute_script("return window.isItReal") == "Yes it is"
    else
      assert true
    end
  end

end
