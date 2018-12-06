defmodule Hound.ResponseParsers.PhantomJs do
  @moduledoc false

  use Hound.ResponseParser

  def handle_error(%{"message" => message} = value) do
    case Jason.decode(message) do
      {:ok, decoded_error} -> decoded_error
      _                    -> value
    end |> do_handle_error
  end

  defp do_handle_error(%{"errorMessage" => "Unable to find element" <> _rest}),
    do: {:error, :no_such_element}
  defp do_handle_error(%{"errorMessage" => msg}),
    do: {:error, msg}
  defp do_handle_error(err),
    do: {:error, err}
end
