defmodule Hound.Helpers.ScriptExecution do

  @doc """
  Execute javascript synchoronously.

  * The first argument is the script to execute.
  * The second argument is a list of arguments that is passed.
    These arguments are accessible in the script via `arguments`.

          execute_script("return(arguments[0] + arguments[1]);", [1, 2])

          execute_script("doSomething(); return(arguments[0] + arguments[1]);")
  """
  @spec execute_script(String.t, List.t) :: any
  def execute_script(script_function, function_args \\ []) do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].ScriptExecution.execute_script(script_function, function_args)
  end


  @doc """
  Execute javascript asynchoronously.

  * The first argument is the script to execute.
  * The second argument is a list of arguments that is passed.
    These arguments are accessible in the script via `arguments`.

  Webdriver passes a callback function as the last argument to the script.
  When your script has completed execution, it has to call the last argument,
  which is a callback function, to indicate that the execute is complete.

      # Once we perform whatever we want,
      # we call the callback function with the arguments that must be returned.
      execute_script_async("doSomething(); arguments[arguments.length-1]('hello')", [])

      # We have no arguments to pass, so we'll skip the second argument.
      execute_script_async("console.log('hello'); doSomething(); arguments[arguments.length-1]()")

  Unless you call the callback function, the function is not assumed to be completed.
  It will error out.
  """
  @spec execute_script_async(String.t, List.t) :: any
  def execute_script_async(script_function, function_args \\ []) do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].ScriptExecution.execute_script_async(script_function, function_args)
  end
end
