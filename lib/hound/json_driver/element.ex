defmodule Hound.JsonDriver.Element do
  import Hound.JsonDriver.Utils

  @type element_selector :: {atom, String.t}
  @type element :: element_selector | String.t

  @doc """
  Gets visible text of element. Requires the element ID.

      element_id = find_element(:css, ".example")
      visible_text(element_id)

  You can also directly pass the selector as a tuple.

      visible_text({:css, ".example"})
  """
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


  @doc """
  Enters value into field.

  It does not clear the field before entering the new value. Anything passed is added to the value already present.

      element_id = find_element(:id, "example")
      input_into_field(element_id, "John Doe")

  You can also pass the selector as a tuple, for the first argument.

      input_into_field({:id, "example"}, "John Doe")
  """
  @spec input_into_field(element, String.t) :: :ok
  def input_into_field(element, input) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/element/#{element_id}/value", [value: [input]])
  end


  @doc """
  Sets a field's value. The difference with `input_info_field` is that, the field is cleared before entering the new value.

      element_id = find_element(:id, "example")
      fill_field(element_id, "John Doe")

  You can also pass the selector as a tuple, for the first argument.

      fill_field({:id, "example"}, "John Doe")
  """
  @spec fill_field(element, String.t) :: :ok
  def fill_field(element, input) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    clear_field(element_id)
    make_req(:post, "session/#{session_id}/element/#{element_id}/value", [value: [input]])
  end


  @doc """
  Gets an element's tag name.

      element_id = find_element(:class, "example")
      tag_name(element_id)

  You can also directly pass the selector as a tuple.

      tag_name({:class, "example"})
  """
  @spec tag_name(element) :: String.t
  def tag_name(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/name")
  end


  @doc """
  Clears textarea or input field's value

      element_id = find_element(:class, "example")
      clear_field(element_id)

  You can also directly pass the selector as a tuple.

      clear_field({:class, "example"})
  """
  @spec clear_field(element) :: :ok
  def clear_field(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/element/#{element_id}/clear")
  end


  @doc """
  Checks if a radio input group or checkbox has any value selected.

      element_id = find_element(:name, "example")
      selected?(element_id)

  You can also pass the selector as a tuple.

      selected?({:name, "example"})
  """
  @spec selected?(element) :: :true | :false
  def selected?(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/selected")
  end


  @doc """
  Checks if an input field is enabled.

      element_id = find_element(:name, "example")
      enabled?(element_id)

  You can also pass the selector as a tuple.

      enabled?({:name, "example"})
  """
  @spec element_enabled?(element) :: :true | :false
  def element_enabled?(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/enabled")
  end


  @doc """
  Gets an element's attribute value.

      element_id = find_element(:name, "example")
      attribute_value(element_id, "data-greeting")

  You can also pass the selector as a tuple, for the first argument

      attribute_value({:name, "example"}, "data-greeting")
  """
  @spec attribute_value(element, String.t) :: String.t | :nil
  def attribute_value(element, attribute_name) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/attribute/#{attribute_name}")
  end


  @doc "Check if two element IDs refer to the same DOM element"
  @spec same_element?(String.t, String.t) :: :true | :false
  def same_element?(element_id1, element_id2) do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id1}/equals/#{element_id2}")
  end


  @doc "Check if an element is currently displayed"
  @spec element_displayed?(element) :: :true | :false
  def element_displayed?(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/displayed")
  end


  @doc "Get element's location on page"
  @spec element_location(element) :: tuple
  def element_location(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    result = make_req(:get, "session/#{session_id}/element/#{element_id}/location")
    {result["x"], result["y"]}
  end


  @doc "Get element size pixels"
  @spec element_size(element) :: tuple
  def element_size(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    result = make_req(:get, "session/#{session_id}/element/#{element_id}/size")
    {result["width"], result["height"]}
  end


  @doc """
  Gets an element's computed CSS property.

      element_id = find_element(:name, "example")
      css_property(element_id, "display")

  You can also pass the selector as a tuple, for the first argument

      css_property({:name, "example"}, "display")
  """
  @spec css_property(element, String.t) :: String.t
  def css_property(element, property_name) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/css/#{property_name}")
  end


  @doc """
  Click on an element. You can also use this to click on checkboxes and radio buttons.

      element_id = find_element(:id, ".example")
      click(element_id)

  You can also directly pass the selector as a tuple.

      click({:id, "example"})
  """
  @spec click(element) :: :ok
  def click(element) do
    element_id = get_element_id(element)
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/element/#{element_id}/click")
  end


  @doc """
  Sends a submit event to any field or form element.

      element_id = find_element(:name, "username")
      submit(element_id)

  You can also directly pass the selector as a tuple.

      submit({:name, "username"})
  """
  @spec submit_element(element) :: :ok
  def submit_element(element) do
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
