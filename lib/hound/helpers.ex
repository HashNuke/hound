defmodule Hound.Helpers do
  @moduledoc false

  defmacro __using__([]) do
    {:ok, driver, _} = Hound.get_driver_info
    quote do
      use unquote(driver)
    end
  end

end
