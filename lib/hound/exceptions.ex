defmodule Hound.Error do
  defexception [:message]
end

defmodule Hound.NoSuchElementError do
  defexception [:strategy, :selector, :parent]

  def message(err) do
    parent_text = if err.parent, do: "in #{err.parent} ", else: ""
    "No element #{parent_text}found for #{err.strategy} '#{err.selector}'"
  end
end

defmodule Hound.InvalidElementError do
  defexception [:value]

  def message(err) do
    "Could not transform value #{inspect(err.value)} to element"
  end
end

defmodule Hound.NotSupportedError do
  defexception [:function, :browser, :driver]

  def message(err) do
    %{browser: browser, driver: driver} = driver_info(err)
    "#{err.function} is not supported by driver #{driver} with browser #{browser}"
  end

  @doc "Raises an exception if the given parameters match the current driver"
  defmacro raise_for(params) do
    function = case __CALLER__.function do
                 {func, arity} -> "#{func}/#{arity}"
                 func          -> to_string(func)
               end
    quote bind_quoted: binding() do
      Hound.NotSupportedError.raise_for(params, function)
    end
  end

  @doc "Same as raise_for/1 but accepts a function name to customize the error output"
  def raise_for(params, function) when is_map(params) do
    {:ok, info} = Hound.ConnectionServer.driver_info
    if Map.take(info, Map.keys(params)) == params do
      raise __MODULE__, function: function, browser: info.browser, driver: info.driver
    end
  end

  defp driver_info(err) do
    if err.browser && err.driver do
      Map.take(err, [:browser, :driver])
    else
      {:ok, info} = Hound.ConnectionServer.driver_info
      %{driver: err.driver || info.driver, browser: err.browser || info.browser}
    end
  end
end

defmodule Hound.InvalidMetadataError do
  defexception [:value]

  def message(err) do
    "could not parse metadata for value #{err.value}"
  end
end
