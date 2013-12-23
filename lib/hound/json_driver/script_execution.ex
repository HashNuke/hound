defmodule Hound.JsonDriver.ScriptExecution do
  import Hound.JsonDriver.Utils

  @doc """
  Execute javascript synchoronously.

  * The first argument is the script to execute.
  * The second argument is a list of arguments that is passed.
    These arguments are accessible in the script via `arguments`.
  """
  @spec execute_script(String.t, List.t) :: any
  def execute_script(script_function, function_args // []) do
    session_id = Hound.get_current_session_id
    make_req(:post,
      "session/#{session_id}/execute",
      [script: script_function, args: function_args]
    )
  end


  @doc """
  Execute javascript asynchoronously.

  * The first argument is the script to execute.
  * The second argument is a list of arguments that is passed.
    These arguments are accessible in the script via `arguments`.

    Webdriver passes a callback function as the last argument to the script.
    When your script has completed execution, it has to call the last argument, to indicate that the execute is complete.
  """
  @spec execute_script_async(String.t, List.t) :: any
  def execute_script_async(script_function, function_args // []) do
    session_id = Hound.get_current_session_id
    make_req(:post,
      "session/#{session_id}/execute_async",
      [script: script_function, args: function_args]
    )
  end
end
