defmodule Hound.Element do
  @moduledoc """
  A representation of a web element
  """

  defstruct uuid: nil
  @type t :: %__MODULE__{uuid: String.t}

  @type strategy :: :css | :class | :id | :name | :tag | :xpath | :link_text | :partial_link_text
  @type matcher  :: {strategy, String.t}
  @type selector :: t | matcher

  @doc """
  Returns true if the argument is an Element
  """
  @spec element?(any) :: boolean
  def element?(%__MODULE__{}), do: true
  def element?(_),             do: false

  @doc """
  Returns an element from a driver element response
  """
  @spec from_response(map) :: t
  def from_response(element) when is_map(element) do
    element |> Map.to_list |> from_response
  end
  def from_response([{"ELEMENT", uuid}]), do: %__MODULE__{uuid: uuid}
  def from_response([{"element-" <> _id, uuid}]), do: %__MODULE__{uuid: uuid}
  def from_response(value), do: raise Hound.InvalidElementError, value: value
end

defimpl Jason.Encoder, for: Hound.Element do
  def encode(%{uuid: uuid}, options) do
    Jason.Encode.map(%{"ELEMENT" => uuid}, options)
  end
end

defimpl String.Chars, for: Hound.Element do
  def to_string(elem) do
    elem.uuid
  end
end
