defmodule Hound.Helpers do
  @moduledoc false

  defmacro __using__([]) do
    {:ok, driver, _} = Hound.get_driver_info
    quote do
      use unquote(driver)
      import unquote(__MODULE__)
    end
  end


  defmacro hound_session do
    quote do
      setup do
        Hound.start_session
        :ok
      end

      teardown do
        Hound.end_session
        :ok
      end
    end
  end

end
