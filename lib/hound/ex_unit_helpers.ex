defmodule Hound.Helpers do

  defmacro __using__([]) do
    {:ok, driver, _} = Hound.get_driver_info
    quote do
      use unquote(driver)
    end
  end

end
