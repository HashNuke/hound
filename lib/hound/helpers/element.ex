defmodule Hound.Helpers.Element do
  @moduledoc "Functions to work with an element"

  import Hound.RequestUtils

  @doc """
  Gets visible text of element. Requires the element.

      element = find_element(:css, ".example")
      visible_text(element)

  You can also directly pass the selector as a tuple.

      visible_text({:css, ".example"})
  """
  @spec visible_text(Hound.Element.selector) :: String.t
  def visible_text(element) do
    element = get_element(element)
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element}/text")
  end


  @spec inner_html(Hound.Element.selector) :: String.t
  def inner_html(element) do
    attribute_value(element, "innerHTML")
  end


  @spec inner_text(Hound.Element.selector) :: String.t
  def inner_text(element) do
    attribute_value(element, "innerText")
  end
  
  @spec outer_html(Hound.Element.selector) :: String.t
  def outer_html(element) do
    attribute_value(element, "outerHTML")
  end

  @doc """
  Enters value into field.

  It does not clear the field before entering the new value. Anything passed is added to the value already present.

      element = find_element(:id, "example")
      input_into_field(element, "John Doe")

  You can also pass the selector as a tuple, for the first argument.

      input_into_field({:id, "example"}, "John Doe")
  """
  @spec input_into_field(Hound.Element.selector, String.t) :: :ok
  def input_into_field(element, input) do
    element = get_element(element)
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/element/#{element}/value", %{value: ["#{input}"]})
  end


  @doc """
  Sets a field's value. The difference with `input_into_field` is that, the field is cleared before entering the new value.

      element = find_element(:id, "example")
      fill_field(element, "John Doe")

  You can also pass the selector as a tuple, for the first argument.

      fill_field({:id, "example"}, "John Doe")
  """
  @spec fill_field(Hound.Element.selector, String.t) :: :ok
  def fill_field(element, input) do
    element = get_element(element)
    session_id = Hound.current_session_id
    clear_field(element)
    make_req(:post, "session/#{session_id}/element/#{element}/value", %{value: ["#{input}"]})
  end


  @doc """
  Gets an element's tag name.

      element = find_element(:class, "example")
      tag_name(element)

  You can also directly pass the selector as a tuple.

      tag_name({:class, "example"})
  """
  @spec tag_name(Hound.Element.selector) :: String.t
  def tag_name(element) do
    element = get_element(element)
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element}/name")
  end


  @doc """
  Clears textarea or input field's value

      element = find_element(:class, "example")
      clear_field(element)

  You can also directly pass the selector as a tuple.

      clear_field({:class, "example"})
  """
  @spec clear_field(Hound.Element.selector) :: :ok
  def clear_field(element) do
    element = get_element(element)
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/element/#{element}/clear")
  end


  @doc """
  Checks if a radio input group or checkbox has any value selected.

      element = find_element(:name, "example")
      selected?(element)

  You can also pass the selector as a tuple.

      selected?({:name, "example"})
  """
  @spec selected?(Hound.Element.selector) :: boolean
  def selected?(element) do
    element = get_element(element)
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element}/selected")
  end


  @doc """
  Checks if an input field is enabled.

      element = find_element(:name, "example")
      element_enabled?(element)

  You can also pass the selector as a tuple.

      element_enabled?({:name, "example"})
  """
  @spec element_enabled?(Hound.Element.selector) :: boolean
  def element_enabled?(element) do
    element = get_element(element)
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element}/enabled")
  end


  @doc """
  Gets an element's attribute value.

      element = find_element(:name, "example")
      attribute_value(element, "data-greeting")

  You can also pass the selector as a tuple, for the first argument

      attribute_value({:name, "example"}, "data-greeting")
  """
  @spec attribute_value(Hound.Element.selector, String.t) :: String.t | :nil
  def attribute_value(element, attribute_name) do
    element = get_element(element)
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element}/attribute/#{attribute_name}")
  end


  @doc """
  Checks if an element has a given class.

      element = find_element(:class, "another_example")
      has_class?(element, "another_class")

  You can also pass the selector as a tuple, for the first argument

      has_class?({:class, "another_example"}, "another_class")
  """
  @spec has_class?(Hound.Element.selector, String.t) :: boolean
  def has_class?(element, class) do
    class_attribute = attribute_value(element, "class")
    String.split(class_attribute) |> Enum.member?(class)
  end


  @doc """
  Checks if two elements refer to the same DOM element.

      element1 = find_element(:name, "username")
      element2 = find_element(:id, "user_name")
      same_element?(element1, element2)
  """
  @spec same_element?(Hound.Element.t, Hound.Element.t) :: boolean
  def same_element?(element1, element2) do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element1}/equals/#{element2}")
  end


  @doc """
  Checks if an element is currently displayed.

      element = find_element(:name, "example")
      element_displayed?(element)

  You can also pass the selector as a tuple.

      element_displayed?({:name, "example"})
      
  Note: If you'd like to check presence of elements in the DOM use `element?/2`, 
  `element_displayed?/1` will only consider elements that are always present in the DOM, either in visible or hidden state.
  """
  @spec element_displayed?(Hound.Element.selector) :: :true | :false
  def element_displayed?(element) do
    element = get_element(element)
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element}/displayed")
  end


  @doc """
  Gets an element's location on page. It returns the location as a tuple of the form {x, y}.

      element = find_element(:name, "example")
      element_location(element)

  You can also pass the selector as a tuple.

      element_location({:name, "example"})
  """
  @spec element_location(Hound.Element.selector) :: {non_neg_integer(), non_neg_integer()}
  def element_location(element) do
    element = get_element(element)
    session_id = Hound.current_session_id
    result = make_req(:get, "session/#{session_id}/element/#{element}/location")
    {result["x"], result["y"]}
  end


  @doc """
  Gets an element's size in pixels. It returns the size as a tuple of the form {width, height}.

      element = find_element(:name, "example")
      element_location(element)

  You can also pass the selector as a tuple.

      element_location({:name, "example"})
  """
  @spec element_size(Hound.Element.selector) :: {non_neg_integer(), non_neg_integer()}
  def element_size(element) do
    element = get_element(element)
    session_id = Hound.current_session_id
    result = make_req(:get, "session/#{session_id}/element/#{element}/size")
    {result["width"], result["height"]}
  end


  @doc """
  Gets an element's computed CSS property.

      element = find_element(:name, "example")
      css_property(element, "display")

  You can also pass the selector as a tuple, for the first argument

      css_property({:name, "example"}, "display")
  """
  @spec css_property(Hound.Element.selector, String.t) :: String.t
  def css_property(element, property_name) do
    element = get_element(element)
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element}/css/#{property_name}")
  end


  @doc """
  Click on an element. You can also use this to click on checkboxes and radio buttons.

      element = find_element(:id, "example")
      click(element)

  You can also directly pass the selector as a tuple.

      click({:id, "example"})
  """
  @spec click(Hound.Element.selector) :: :ok
  def click(element) do
    element = get_element(element)
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/element/#{element}/click")
  end


  @doc """
  Moves the mouse to a given position within the given element. X and Y are relatively to the element
  and start from top left.

      element = find_element(:id, "example")
      move_to(element, 10, 10)

  You can also directly pass the selector as a tuple.

      move_to({:id, "example"}, 10, 10)
  """
  @spec move_to(Hound.Element.selector, integer, integer) :: :ok
  def move_to(element, xoffset, yoffset) do
    element = get_element(element)
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/moveto", %{element: element.uuid, xoffset: xoffset, yoffset: yoffset})
  end

  @doc """
  Sends a submit event to any field or form element.

      element = find_element(:name, "username")
      submit_element(element)

  You can also directly pass the selector as a tuple.

      submit_element({:name, "username"})
  """
  @spec submit_element(Hound.Element.selector) :: :ok
  def submit_element(element) do
    element = get_element(element)
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/element/#{element}/submit")
  end


  @doc false
  defp get_element({strategy, selector}),
    do: Hound.Helpers.Page.find_element(strategy, selector)
  defp get_element(%Hound.Element{} = elem),
    do: elem
end
