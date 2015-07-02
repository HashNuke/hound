defmodule Hound.Matchers do
  @moduledoc false

  defmacro __using__([]) do
    quote do
      import Hound.Matchers.Text
      import unquote(__MODULE__)
    end
  end
end
