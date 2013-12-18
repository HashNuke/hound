defmodule Hound.Helpers.Element do

  @doc "Get visible text of element"
  defmacro visible_text(element_id) do
    quote do
      visible_text(var!(meta[:hound_connection]), var!(meta[:hound_session_id]), element_id)
    end
  end


  @doc "Set value of element. Sends a sequence of key strokes"
  defmacro set_value(element_id, input) do
    quote do
      set_value(var!(meta[:hound_connection]), var!(meta[:hound_session_id]), element_id, input)
    end
  end


  @doc "Get an element's tag name"
  defmacro tag_name(element_id) do
    quote do
      tag_name(var!(meta[:hound_connection]), var!(meta[:hound_session_id]), element_id)
    end
  end


  @doc "Clear textarea or input element's value"
  defmacro clear_field(element_id) do
    quote do
      clear_field(var!(meta[:hound_connection]), var!(meta[:hound_session_id]), element_id)
    end
  end


  @doc "Check if a checkbox or radio input group has any option selected"
  defmacro selected?(element_id) do
    quote do
      selected?(var!(meta[:hound_connection]), var!(meta[:hound_session_id]), element_id)
    end
  end


  @doc "Check if an input field is enabled"
  defmacro enabled?(element_id) do
    quote do
      enabled?(var!(meta[:hound_connection]), var!(meta[:hound_session_id]), element_id)
    end
  end


  @doc "Get an element's attribute value"
  defmacro attribute_value(element_id, attribute_name) do
    quote do
      attribute_value(var!(meta[:hound_connection]), var!(meta[:hound_session_id]), element_id, attribute_name)
    end
  end


  @doc "Check if two element IDs refer to the same DOM element"
  defmacro same?(element_id1, element_id2) do
    quote do
      same?(var!(meta[:hound_connection]), var!(meta[:hound_session_id]), element_id1, element_id2)
    end
  end


  @doc "Check if an element is currently displayed"
  defmacro displayed?(element_id) do
    quote do
      displayed?(var!(meta[:hound_connection]), var!(meta[:hound_session_id]), element_id)
    end
  end


  @doc "Get element's location on page"
  defmacro element_location(element_id) do
    quote do
      element_location(var!(meta[:hound_connection]), var!(meta[:hound_session_id]), element_id)
    end
  end


  @doc "Get element size pixels"
  defmacro element_size(element_id) do
    quote do
      element_size(var!(meta[:hound_connection]), var!(meta[:hound_session_id]), element_id)
    end
  end


  @doc "Get an element's computed CSS property"
  defmacro css_property(element_id, property_name) do
    quote do
      css_property(
        var!(meta[:hound_connection]),
        var!(meta[:hound_session_id]),
        element_id,
        property_name
      )
    end
  end

end
