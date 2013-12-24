defmodule Hound.JsonDriver.Element do
  import Hound.JsonDriver.Utils

  @doc "Get visible text of element"
  @spec visible_text(String.t) :: String.t
  def visible_text(element_id) do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}")
  end

  @doc "Set value of element. Sends a sequence of key strokes"
  @spec set_value(String.t, String.t) :: :ok
  def set_value(element_id, input) do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/element/#{element_id}/value", [value: [input]])
  end

  @doc "Get an element's tag name"
  @spec tag_name(String.t) :: String.t
  def tag_name(element_id) do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/name")
  end

  @doc "Clear textarea or input element's value"
  @spec clear_field(String.t) :: :ok
  def clear_field(element_id) do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/element/#{element_id}/clear")
  end

  @doc "Check if a checkbox or radio input group has any option selected"
  @spec selected?(String.t) :: :true | :false
  def selected?(element_id) do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/selected")
  end

  @doc "Check if an input field is enabled"
  @spec enabled?(String.t) :: :true | :false
  def enabled?(element_id) do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/enabled")
  end

  @doc "Get an element's attribute value"
  @spec attribute_value(String.t, String.t) :: String.t | :nil
  def attribute_value(element_id, attribute_name) do
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
  @spec displayed?(String.t) :: :true | :false
  def displayed?(element_id) do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/displayed")
  end

  @doc "Get element's location on page"
  @spec element_location(String.t) :: tuple
  def element_location(element_id) do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/location")
  end

  @doc "Get element size pixels"
  @spec element_size(String.t) :: tuple
  def element_size(element_id) do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/size")
  end

  @doc "Get an element's computed CSS property"
  @spec css_property(String.t, String.t) :: String.t
  def css_property(element_id, property_name) do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/css/#{property_name}")
  end


  @doc "Click on element"
  @spec click(String.t) :: :ok
  def click(element_id) do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/element/#{element_id}/click")
  end


  @doc "Submit form"
  @spec submit(String.t) :: :ok
  def submit(element_id) do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/element/#{element_id}/submit")
  end
end
