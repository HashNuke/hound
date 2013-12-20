defmodule HoundTest do
  use ExUnit.Case
  use Hound.Helpers

  setup do
    Hound.start_session
    :ok
  end

  test "should return driver info" do
    navigate_to "http://google.com"
    assert(true)
  end


  test "should return the current session ID" do
  end


  test "should be able to run multiple sessions" do
  end


  test "Should destroy all sessions for current process" do
    Hound.end_session
    assert :gen_server.call(:hound_sessions, :all_sessions_for_pid), []
  end


  teardown do
    :ok = Hound.end_session
  end
end
