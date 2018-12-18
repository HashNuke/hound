defmodule HoundTest do
  use ExUnit.Case
  use Hound.Helpers

  setup do
    Hound.start_session
    parent = self()
    on_exit fn-> Hound.end_session(parent) end
    :ok
  end

  test "should return driver info" do
    {:ok, driver_info} = Hound.driver_info
    assert driver_info[:driver_type] == nil
  end


  test "should return the current session ID" do
    assert is_binary(Hound.current_session_id)
  end

  test "should return all sessions" do
    assert Hound.SessionServer.all_sessions |> Enum.member?(Hound.current_session_id)
  end

  test "should destroy all sessions for current process" do
    Hound.end_session
    assert Hound.SessionServer.all_sessions_for_pid(self()) == %{}
  end

end
