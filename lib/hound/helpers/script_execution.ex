defmodule Hound.Helpers.ScriptExecution do
  @moduledoc "Functions to execute javascript"

  import Hound.RequestUtils

  @doc """
  Execute javascript synchronously.

  * The first argument is the script to execute.
  * The second argument is a list of arguments that is passed.
    These arguments are accessible in the script via `arguments`.

          execute_script("return(arguments[0] + arguments[1]);", [1, 2])

          execute_script("doSomething(); return(arguments[0] + arguments[1]);")
  """
  @spec execute_script(String.t, list) :: any
  def execute_script(script_function, function_args \\ []) do
    session_id = Hound.current_session_id
    make_req(:post,
      "session/#{session_id}/execute",
      %{script: script_function, args: function_args}
    )
  end


  @doc """
  Execute javascript asynchronously.

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
  @spec execute_script_async(String.t, list) :: any
  def execute_script_async(script_function, function_args \\ []) do
    session_id = Hound.current_session_id
    make_req(:post,
      "session/#{session_id}/execute_async",
      %{script: script_function, args: function_args}
    )
  end

  @doc """
  Execute a phantomjs script to configure callbacks.
  This will only work with phantomjs driver.

  * The first argument is the script to execute.
  * The second argument is a list of arguments that is passed.
    These arguments are accessible in the script via `arguments`.

          execute_phantom_script("return(arguments[0] + arguments[1]);", [1, 2])

          execute_phantom_script("doSomething(); return(arguments[0] + arguments[1]);")

  * NOTE: "this" in the context of the script function refers to the phantomjs
    result of require('webpage').create().

    To use it, capture it in a variable at the beginning of the script.  Example:

     page = this;

     page.onResourceRequested = function(requestData, request) {
       // Do something with the request
     };

  """
  @spec execute_phantom_script(String.t, list) :: any
  def execute_phantom_script(script_function, function_args \\ []) do
    session_id = Hound.current_session_id
    make_req(:post,
      "/session/#{session_id}/phantom/execute",
      %{script: script_function, args: function_args}
    )
  end
end
