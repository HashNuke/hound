defmodule Hound.ExUnitHelpers.Dialog do

  defmacro dialog_text do
    quote do
      dialog_text(var!(meta[:hound_connection]), var!(meta[:hound_session_id]))
    end
  end


  defmacro input_into_prompt(input) do
    quote do
      input_into_prompt(
        var!(meta[:hound_connection]),
        var!(meta[:hound_session_id]),
        unquote(input)
      )
    end
  end


  defmacro accept_dialog do
    quote do
      accept_dialog var!(meta[:hound_connection]), var!(meta[:hound_session_id])
    end
  end


  defmacro dismiss_dialog do
    quote do
      dismiss_dialog var!(meta[:hound_connection]), var!(meta[:hound_session_id])
    end
  end

end
