defmodule Hound.Helpers do
  @moduledoc false

  defmacro __using__([]) do
    quote do
      import Hound
      import Hound.Helpers.Cookie
      import Hound.Helpers.Dialog
      import Hound.Helpers.Element
      import Hound.Helpers.Navigation
      import Hound.Helpers.Orientation
      import Hound.Helpers.Page
      import Hound.Helpers.Screenshot
      import Hound.Helpers.ScriptExecution
      import Hound.Helpers.Session
      import Hound.Helpers.Window
      import Hound.Helpers.Log
      import Hound.Matchers
      import unquote(__MODULE__)
    end
  end


  defmacro hound_session(opts \\ []) do
    quote do
      setup do
        Hound.start_session(unquote(opts))

        :ok
      end
    end
  end

end
