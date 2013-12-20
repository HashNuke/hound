defmodule HoundTest do
  use ExUnit.Case, async: true
  use Hound.Helpers

  setup do
    Hound.start_session
    :ok
  end

  test "should return driver info" do
    {:ok, driver, _driver_info} = Hound.get_driver_info
    assert is_atom(driver)
  end


  test "should return the current session ID" do
    assert is_binary(Hound.get_current_session_id)
  end


  test "should be able to run multiple sessions" do
    url1 = "http://localhost:9090/page1.html"
    url2 = "http://localhost:9090/page2.html"

    # Navigate to a url
    navigate_to(url1)

    # Change to another session
    Hound.change_session_to :another_session
    # Navigate to a url in the second session
    navigate_to(url2)
    # Then assert url
    assert url2 == current_url

    # Now go back to the default session
    Hound.change_to_default_session
    # Assert if the url is the one we visited
    assert url1 == current_url    
  end


  test "Should destroy all sessions for current process" do
    Hound.end_session
    assert :gen_server.call(:hound_sessions, :all_sessions_for_pid) == []
  end


  teardown do
    :ok = Hound.end_session
  end
end
