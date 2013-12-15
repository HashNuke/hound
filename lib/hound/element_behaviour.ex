defmodule Hound.ElementBehaviour do
  use Behaviour

  @doc "Get visible text of element"
  defcallback visible_text(session_id :: String.t, element_identifier :: String.t) :: String.t

  @doc "Set value of element. Sends a sequence of key strokes"
  defcallback set_value(session_id :: String.t, element_identifier :: String.t, List.t) :: :ok

  @doc "Get an element's tag name"
  defcallback tag_name(session_id :: String.t, element_identifier :: String.t) :: String.t

  @doc "Clear textarea or input element's value"
  defcallback clear_field(session_id :: String.t, element_identifier :: String.t) :: :ok

  @doc "Check if a checkbox or radio input group has any option selected"
  defcallback selected?(session_id :: String.t, element_identifier :: String.t) :: :true | :false

  @doc "Check if an input field is enabled"
  defcallback enabled?(session_id :: String.t, element_identifier :: String.t) :: :true | :false

  @doc "Get an element's attribute value"
  defcallback attribute_value(session_id :: String.t, element_identifier :: String.t, attribute_name :: String.t) :: String.t | :nil

  @doc "Check if two element IDs refer to the same DOM element"
  defcallback same?(session_id :: String.t, element_identifier1 :: String.t, element_identifier2 :: String.t) :: :true | :false

  @doc "Check if an element is currently displayed"
  defcallback displayed?(session_id :: String.t, element_identifier :: String.t) :: :true | :false

  @doc "Get element's location on page"
  defcallback element_location(session_id :: String.t, element_identifier :: String.t) :: tuple

  @doc "Get element size pixels"
  defcallback element_size(session_id :: String.t, element_identifier :: String.t) :: tuple

  @doc "Get an element's computed CSS property"
  defcallback css_property(session_id :: String.t, element_identifier :: String.t, property_name :: String.t) :: String.t
end