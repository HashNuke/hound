defmodule DialogTest do
  use ExUnit.Case
  use Hound.Helpers

  if Hound.InternalHelpers.driver_supports?("dialog_text") do

    hound_session()

    test "Dialog present" do
      navigate_to "http://localhost:9090/page1.html"
      execute_script("alert('hello')")
      assert dialog_present?() == true
    end

    test "Get dialog text" do
      navigate_to "http://localhost:9090/page1.html"
      execute_script("alert('hello')")
      assert dialog_text() == "hello"
    end


    test "Dismiss dialog" do
      navigate_to "http://localhost:9090/page1.html"
      execute_script("return window.isItReal = confirm('Is it true?')")
      dismiss_dialog()
      assert execute_script("return window.isItReal") == false
    end


    test "Accept dialog" do
      navigate_to "http://localhost:9090/page1.html"
      execute_script("return window.isItReal = confirm('Is it true?')")
      accept_dialog()
      assert execute_script("return window.isItReal") == true
    end


    test "Input into prompt" do
      navigate_to "http://localhost:9090/page1.html"
      execute_script("return window.isItReal = prompt('Is it true?')")
      input_into_prompt("Yes it is")
      accept_dialog()
      assert execute_script("return window.isItReal") == "Yes it is"
    end

  end
end
