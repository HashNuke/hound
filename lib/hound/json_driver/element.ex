defmodule Hound.JsonDriver.Element do
  import Hound.JsonDriver.Utils

  @type element_selector :: {atom, String.t}
  @type element :: element_selector | String.t

  @doc "Get visible text of element"
  @spec visible_text(element) :: String.t
  def visible_text(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    result = make_req(:get, "session/#{session_id}/element/#{element_id}")
    cond do
      is_list(result) ->
        result["text"]
      true ->
        result
    end
  end


  @doc "Inputs value into field.
  It does not clear the field before entering the new value. Anything passed is added to the value already present"
  @spec input_into_field(element, String.t) :: :ok
  def input_into_field(element, input) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/element/#{element_id}/value", [value: [input]])
  end


  @doc "Clear the existing value in a value and enter a new one"
  @spec fill_field(element, String.t) :: :ok
  def fill_field(element, input) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    clear_field(element_id)
    make_req(:post, "session/#{session_id}/element/#{element_id}/value", [value: [input]])
  end


  @doc "Get an element's tag name"
  @spec tag_name(element) :: String.t
  def tag_name(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/name")
  end


  @doc "Clear textarea or input element's value"
  @spec clear_field(element) :: :ok
  def clear_field(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/element/#{element_id}/clear")
  end


  @doc "Check if a checkbox or radio input group has any option selected"
  @spec selected?(element) :: :true | :false
  def selected?(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/selected")
  end


  @doc "Check if an input field is enabled"
  @spec enabled?(element) :: :true | :false
  def enabled?(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/enabled")
  end


  @doc "Get an element's attribute value"
  @spec attribute_value(element, String.t) :: String.t | :nil
  def attribute_value(element, attribute_name) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/attribute/#{attribute_name}")
  end


  @doc "Check if two element IDs refer to the same DOM element"
  @spec same?(String.t, String.t) :: :true | :false
  def same?(element_id1, element_id2) do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id1}/equals/#{element_id2}")
  end


  @doc "Check if an element is currently displayed"
  @spec displayed?(element) :: :true | :false
  def displayed?(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/displayed")
  end


  @doc "Get element's location on page"
  @spec element_location(element) :: tuple
  def element_location(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/location")
  end


  @doc "Get element size pixels"
  @spec element_size(element) :: tuple
  def element_size(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/size")
  end


  @doc "Get an element's computed CSS property"
  @spec css_property(element, String.t) :: String.t
  def css_property(element, property_name) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/css/#{property_name}")
  end


  @doc "Click on element"
  @spec click(element) :: :ok
  def click(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/element/#{element_id}/click")
  end


  @doc "Submit form"
  @spec submit(element) :: :ok
  def submit(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/element/#{element_id}/submit")
  end


  @doc false
  defp get_element_id(element) do
    if is_tuple(element) do
      {strategy, selector} = element
      Hound.JsonDriver.Page.find_element(strategy, selector)
    else
      element
    end
  end
end
