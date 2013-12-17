defmodule Hound.TestHelpers.Dialog do

  defmacro dialog_text do
    quote do
      hi(var!(meta[:session_id]))
    end
  end

  defmacro input_into_prompt(input) do
    quote do
      input_into_prompt(var!(meta[:session_id]), unquote(input))
    end
  end

  defmacro accept_dialog do
    quote do
      accept_dialog var!(meta[:session_id])
    end
  end

  defmacro dismiss_dialog do
    quote do
      dismiss_dialog var!(meta[:session_id])
    end
  end

end