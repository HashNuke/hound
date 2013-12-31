defmodule HoundTest do
  use ExUnit.Case
  use Hound.Helpers

  setup do
    Hound.start_session
    :ok
  end

  test "should return driver info" do
    {:ok, driver_info} = Hound.get_driver_info
    assert is_atom(driver_info[:type])
  end


  test "should return the current session ID" do
    assert is_binary(Hound.get_current_session_id)
  end


  test "Should destroy all sessions for current process" do
    Hound.end_session
    assert :gen_server.call(:hound_sessions, :all_sessions_for_pid) == []
  end


  teardown do
    :ok = Hound.end_session
  end
end
