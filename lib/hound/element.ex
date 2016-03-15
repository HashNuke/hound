defmodule Hound.Element do
  @moduledoc """
  A representation of a web element
  """

  defstruct uuid: nil
  @type t :: %__MODULE__{uuid: String.t}

  @doc """
  Returns true if the argument is an Element
  """
  def element?(%__MODULE__{}), do: true
  def element?(_),             do: false

  @doc """
  Returns an element from a driver element response
  """
  def from_response(%{"ELEMENT" => uuid}), do: %__MODULE__{uuid: uuid}
  def from_response(value) do
    raise Hound.InvalidElementError, value: value
  end
end

defimpl Poison.Encoder, for: Hound.Element do
  def encode(%{uuid: uuid}, options) do
    Poison.Encoder.Map.encode(%{"ELEMENT" => uuid}, options)
  end
end

defimpl String.Chars, for: Hound.Element do
  def to_string(elem) do
    elem.uuid
  end
end
