defmodule Hound.JsonDriver.ScriptExecution do
  import Hound.JsonDriver.Utils

  @doc "Execute javascript synchoronously"
  @spec execute_script(String.t, String.t, String.t, List.t) :: any
  def execute_script(connection, session_id, script_function, function_args) do
    make_req(connection,
      :post,
      "session/#{session_id}/execute",
      [script: script_function, args: function_args]
    )
  end


  @doc "Execute javascript asynchoronously"
  @spec execute_script_async(String.t, String.t, String.t, List.t) :: any
  def execute_script_async(connection, session_id, script_function, function_args) do
    make_req(connection,
      :post,
      "session/#{session_id}/execute_async",
      [script: script_function, args: function_args]
    )
  end
end
