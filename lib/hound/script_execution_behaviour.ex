defmodule Hound.ScriptExecutionBehaviour do
  use Behaviour

  @doc "Execute javascript synchoronously"
  defcallback execute_script(session_id :: String.t, script_function :: String.t, function_args :: List.t) :: any

  @doc "Execute javascript asynchoronously"
  defcallback execute_script_async(session_id :: String.t, script_function :: String.t, function_args :: List.t) :: any
end
