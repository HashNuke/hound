defmodule Hound.JsonDriver.Page do
  import Hound.JsonDriver.Utils

  @doc "Get source of current page"
  @spec page_source() :: String.t
  def page_source() do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/source")
  end


  @doc "Get the title of the current page"
  @spec page_title() :: String.t
  def page_title() do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/title")
  end


  @doc "Find element on current page"
  @spec find_element(String.t, String.t) :: Dict.t
  def find_element(strategy, selector) do
    session_id = Hound.get_current_session_id
    params = [using: Hound.InternalHelpers.selector_strategy(strategy), value: selector]
    case make_req(:post, "session/#{session_id}/element", params) do
      [{"ELEMENT", element_id}] ->
        element_id
      value ->
        value
    end
  end


  @doc "Find elements on current page"
  @spec find_all_elements(atom, String.t) :: List.t
  def find_all_elements(strategy, selector) do
    session_id = Hound.get_current_session_id
    params = [using: Hound.InternalHelpers.selector_strategy(strategy), value: selector]
    case make_req(:post, "session/#{session_id}/elements", params) do
      {:error, value} ->
        {:error, value}
      elements ->
        lc [{"ELEMENT", element_id}] inlist elements do
          element_id
        end
    end
  end


  @doc "Find element within element"
  @spec find_within_element(String.t, atom,String.t) :: Dict.t
  def find_within_element(element_id, strategy, selector) do
    session_id = Hound.get_current_session_id
    params = [using: Hound.InternalHelpers.selector_strategy(strategy), value: selector]
    case make_req(:post, "session/#{session_id}/element/#{element_id}/element", params) do
      [{"ELEMENT", element_id}] ->
        element_id
      value ->
        value
    end
  end


  @doc "Find elements within element"
  @spec find_all_within_element(String.t, atom, String.t) :: List.t
  def find_all_within_element(element_id, strategy, selector) do
    session_id = Hound.get_current_session_id
    params = [using: Hound.InternalHelpers.selector_strategy(strategy), value: selector]
    case make_req(:post, "session/#{session_id}/element/#{element_id}/elements", params) do
      {:error, value} ->
        {:error, value}
      elements ->
        lc [{"ELEMENT", element_id}] inlist elements do
          element_id
        end
    end
  end


  @doc "Get element on page currently in focus"
  @spec element_in_focus() :: Dict.t
  def element_in_focus do
    session_id = Hound.get_current_session_id
    case make_req(:post, "session/#{session_id}/element/active") do
      [{"ELEMENT", element_id}] ->
        element_id
      value ->
        value
    end
  end


  @doc "Send sequence of key strokes to active element. The modifier keys are not released after this command is run."
  @spec send_keys(List.t) :: :ok
  def send_keys(keys) do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/keys", [value: keys])
  end
end
