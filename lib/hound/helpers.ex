defmodule Hound.TestHelpers do

  defmacro greet(y, z) do
    quote do
      hi(var!(meta), unquote(y), unquote(z))
    end
  end

end