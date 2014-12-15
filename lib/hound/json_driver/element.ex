defmodule Hound.JsonDriver.Element do
  @moduledoc "Provides functions related to elements."

  import Hound.JsonDriver.Utils

  @type element_selector :: {atom, String.t}
  @type element :: element_selector | String.t


  @spec visible_text(element) :: String.t
  def visible_text(element) do
    element_id = get_element_id(element)
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/text")
  end


  @spec input_into_field(element, String.t) :: :ok
  def input_into_field(element, input) do
    element_id = get_element_id(element)
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/element/#{element_id}/value", %{value: ["#{input}"]})
  end


  @spec fill_field(element, String.t) :: :ok
  def fill_field(element, input) do
    element_id = get_element_id(element)
    session_id = Hound.current_session_id
    clear_field(element_id)
    make_req(:post, "session/#{session_id}/element/#{element_id}/value", %{value: ["#{input}"]})
  end


  @spec tag_name(element) :: String.t
  def tag_name(element) do
    element_id = get_element_id(element)
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/name")
  end


  @spec clear_field(element) :: :ok
  def clear_field(element) do
    element_id = get_element_id(element)
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/element/#{element_id}/clear")
  end


  @spec selected?(element) :: :true | :false
  def selected?(element) do
    element_id = get_element_id(element)
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/selected")
  end


  @spec element_enabled?(element) :: :true | :false
  def element_enabled?(element) do
    element_id = get_element_id(element)
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/enabled")
  end


  @spec attribute_value(element, String.t) :: String.t | :nil
  def attribute_value(element, attribute_name) do
    element_id = get_element_id(element)
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/attribute/#{attribute_name}")
  end


  @spec same_element?(String.t, String.t) :: :true | :false
  def same_element?(element_id1, element_id2) do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id1}/equals/#{element_id2}")
  end


  @spec element_displayed?(element) :: :true | :false
  def element_displayed?(element) do
    element_id = get_element_id(element)
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/displayed")
  end


  @spec element_location(element) :: tuple
  def element_location(element) do
    element_id = get_element_id(element)
    session_id = Hound.current_session_id
    result = make_req(:get, "session/#{session_id}/element/#{element_id}/location")
    {result["x"], result["y"]}
  end


  @spec element_size(element) :: tuple
  def element_size(element) do
    element_id = get_element_id(element)
    session_id = Hound.current_session_id
    result = make_req(:get, "session/#{session_id}/element/#{element_id}/size")
    {result["width"], result["height"]}
  end


  @spec css_property(element, String.t) :: String.t
  def css_property(element, property_name) do
    element_id = get_element_id(element)
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element_id}/css/#{property_name}")
  end


  @spec click(element) :: :ok
  def click(element) do
    element_id = get_element_id(element)
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/element/#{element_id}/click")
  end


  @spec submit_element(element) :: :ok
  def submit_element(element) do
    element_id = get_element_id(element)
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/element/#{element_id}/submit")
  end


  @doc false
  defp get_element_id(element) do
    if is_tuple(element) do
      {strategy, selector} = element
      Hound.Helpers.Page.find_element(strategy, selector)
    else
      element
    end
  end
end
