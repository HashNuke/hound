defmodule Hound.ExUnitHelpers.ScriptExecution do

  @doc "Execute javascript synchoronously"
  defmacro execute_script(script_function, function_args) do
    quote do
      execute_script(
        var!(meta[:hound_connection]),
        var!(meta[:hound_session_id]),
        script_function,
        function_args
      )
    end
  end


  @doc "Execute javascript asynchoronously"
  defmacro execute_script_async(script_function, function_args) do
    quote do
      execute_script_async(
        var!(meta[:hound_connection]),
        var!(meta[:hound_session_id]),
        script_function,
        function_args
      )
    end
  end

end
