defmodule Hound.Helpers.Element do

  @doc "Get visible text of element"
  defmacro visible_text(element_identifier) do
    quote do: visible_text(var!(meta[:session_id]), element_identifier)
  end

  @doc "Set value of element. Sends a sequence of key strokes"
  defmacro set_value(element_identifier, input) do
    quote do: set_value(var!(meta[:session_id]), element_identifier, input)
  end

  @doc "Get an element's tag name"
  defmacro tag_name(element_identifier) do
    quote do: tag_name(var!(meta[:session_id]), element_identifier)
  end

  @doc "Clear textarea or input element's value"
  defmacro clear_field(element_identifier) do
    quote do: clear_field(var!(meta[:session_id]), element_identifier)
  end

  @doc "Check if a checkbox or radio input group has any option selected"
  defmacro selected?(element_identifier) do
    quote do: selected?(var!(meta[:session_id]), element_identifier)
  end

  @doc "Check if an input field is enabled"
  defmacro enabled?(element_identifier) do
    quote do: enabled?(var!(meta[:session_id]), element_identifier)
  end

  @doc "Get an element's attribute value"
  defmacro attribute_value(element_identifier, attribute_name) do
    quote do: attribute_value(var!(meta[:session_id]), element_identifier, attribute_name)
  end

  @doc "Check if two element IDs refer to the same DOM element"
  defmacro same?(element_identifier1, element_identifier2) do
    quote do: same?(var!(meta[:session_id]), element_identifier1, element_identifier2)
  end

  @doc "Check if an element is currently displayed"
  defmacro displayed?(element_identifier) do
    quote do: displayed?(var!(meta[:session_id]), element_identifier)
  end

  @doc "Get element's location on page"
  defmacro element_location(element_identifier) do
    quote do: element_location(var!(meta[:session_id]), element_identifier)
  end

  @doc "Get element size pixels"
  defmacro element_size(element_identifier) do
    quote do: element_size(var!(meta[:session_id]), element_identifier)
  end

  @doc "Get an element's computed CSS property"
  defmacro css_property(element_identifier, property_name) do
    quote do: css_property(var!(meta[:session_id]), element_identifier, property_name)
  end
end
