defmodule Hound.JsonDriver.ScriptExecution do
  import Hound.JsonDriver.Utils

  @spec execute_script(String.t, List.t) :: any
  def execute_script(script_function, function_args \\ []) do
    session_id = Hound.current_session_id
    make_req(:post,
      "session/#{session_id}/execute",
      [script: script_function, args: function_args]
    )
  end


  @spec execute_script_async(String.t, List.t) :: any
  def execute_script_async(script_function, function_args \\ []) do
    session_id = Hound.current_session_id
    make_req(:post,
      "session/#{session_id}/execute_async",
      [script: script_function, args: function_args]
    )
  end
end
