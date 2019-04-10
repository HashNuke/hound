defmodule Hound.ResponseParsers.GeckoDriver do
  @moduledoc false

  use Hound.ResponseParser

  def handle_error(%{"message" => "Unable to locate element:" <> _rest}) do
    {:error, :no_such_element}
  end
end
