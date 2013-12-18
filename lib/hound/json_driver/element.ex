defmodule Hound.JsonDriver.Element do
  import Hound.JsonDriver.Utils

  @doc "Get visible text of element"
  @spec visible_text(Dict.t, String.t, String.t) :: String.t
  def visible_text(connection, session_id, element_id) do
    make_req(connection, :get, "/sessions/#{session_id}/element/#{element_id}")
  end

  @doc "Set value of element. Sends a sequence of key strokes"
  @spec set_value(Dict.t, String.t, String.t, String.t) :: :ok
  def set_value(connection, session_id, element_id, input) do
    make_req(connection, :post, "/sessions/#{session_id}/element/#{element_id}/value", [value: input])
  end

  @doc "Get an element's tag name"
  @spec tag_name(Dict.t, String.t, String.t) :: String.t
  def tag_name(connection, session_id, element_id) do
    make_req(connection, :get, "/sessions/#{session_id}/element/#{element_id}/name")
  end

  @doc "Clear textarea or input element's value"
  @spec clear_field(Dict.t, String.t, String.t) :: :ok
  def clear_field(connection, session_id, element_id) do
    make_req(connection, :post, "/sessions/#{session_id}/element/#{element_id}/clear")
  end

  @doc "Check if a checkbox or radio input group has any option selected"
  @spec selected?(Dict.t, String.t, String.t) :: :true | :false
  def selected?(connection, session_id, element_id) do
    make_req(connection, :get, "/sessions/#{session_id}/element/#{element_id}/selected")
  end

  @doc "Check if an input field is enabled"
  @spec enabled?(Dict.t, String.t, String.t) :: :true | :false
  def enabled?(connection, session_id, element_id) do
    make_req(connection, :get, "/sessions/#{session_id}/element/#{element_id}/enabled")
  end

  @doc "Get an element's attribute value"
  @spec attribute_value(Dict.t, String.t, String.t, String.t) :: String.t | :nil
  def attribute_value(connection, session_id, element_id, attribute_name) do
    make_req(connection, :get, "/sessions/#{session_id}/element/#{element_id}/attribute/#{attribute_name}")
  end

  @doc "Check if two element IDs refer to the same DOM element"
  @spec same?(Dict.t, String.t, String.t, String.t) :: :true | :false
  def same?(connection, session_id, element_id1, element_id2) do
    make_req(connection, :get, "/sessions/#{session_id}/element/#{element_id1}/equals/#{element_id2}")
  end

  @doc "Check if an element is currently displayed"
  @spec displayed?(Dict.t, String.t, String.t) :: :true | :false
  def displayed?(connection, session_id, element_id) do
    make_req(connection, :get, "/sessions/#{element_id}/element/#{element_id}/displayed")
  end

  @doc "Get element's location on page"
  @spec element_location(Dict.t, String.t, String.t) :: tuple
  def element_location(connection, session_id, element_id) do
    make_req(connection, :get, "/sessions/#{session_id}/element/#{element_id}/location")
  end

  @doc "Get element size pixels"
  @spec element_size(Dict.t, String.t, String.t) :: tuple
  def element_size(connection, session_id, element_id) do
    make_req(connection, "/session/#{session_id}/element/#{element_id}/size")
  end

  @doc "Get an element's computed CSS property"
  @spec css_property(Dict.t, String.t, String.t, String.t) :: String.t
  def css_property(connection, session_id, element_id, property_name) do
    make_req(connection, :get, "/session/#{session_id}/element/#{element_id}/css/#{property_name}")
  end


  @doc "Click on element"
  @spec click_on(Dict.t, String.t, String.t) :: :ok
  def click_on(connection, session_id, element_id) do
    make_req(connection, :post, "/session/#{session_id}/element/#{element_id}/click")
  end


  @doc "Submit form"
  @spec submit(Dict.t, String.t, String.t) :: :ok
  def submit(connection, session_id, element_id) do
    make_req(connection, :post, "/session/#{session_id}/element/#{element_id}/submit")
  end
end