defmodule Hound.JsonDriver.Page do
  import Hound.JsonDriver.Utils

  @doc "Get source of current page"
  @spec page_source(Dict.t, String.t) :: String.t
  def page_source(connection, session_id) do
    make_req(connection, :get, "session/#{session_id}/source")
  end

  @doc "Get the title of the current page"
  @spec page_title(Dict.t, String.t) :: String.t
  def page_title(connection, session_id) do
    make_req(connection, :get, "session/#{session_id}/title")
  end

  @doc "Find element on current page"
  @spec find_element(Dict.t, String.t, String.t, String.t) :: Dict.t
  def find_element(connection, session_id, strategy, selector) do
    params = [using: Hound.InternalHelper.selector_strategy(strategy), value: selector]
    make_req(connection, :post, "session/#{session_id}/element", params)
  end

  @doc "Find elements on current page"
  @spec find_all_elements(Dict.t, String.t, atom, String.t) :: List.t
  def find_all_elements(connection, session_id, strategy, selector) do
    params = [using: Hound.InternalHelper.selector_strategy(strategy), value: selector]
    make_req(connection, :post, "session/#{session_id}/elements", params)
  end

  @doc "Find element within element"
  @spec find_within_element(Dict.t, String.t, String.t, atom,String.t) :: Dict.t
  def find_within_element(connection, session_id, element_id, strategy, selector) do
    params = [using: Hound.InternalHelper.selector_strategy(strategy), value: selector]
    make_req(connection, :post, "session/#{session_id}/element/#{element_id}/element", params)
  end

  @doc "Find elements within element"
  @spec find_all_within_element(Dict.t, String.t, String.t, atom, String.t) :: List.t
  def find_all_within_element(connection, session_id, element_id, strategy, selector) do
    params = [using: Hound.InternalHelper.selector_strategy(strategy), value: selector]
    make_req(connection, :post, "session/#{session_id}/element/#{element_id}/elements", params)
  end

  @doc "Get element on page currently in focus"
  @spec element_in_focus(Dict.t, String.t) :: Dict.t
  def element_in_focus(connection, session_id) do
    make_req(connection, :post, "session/#{session_id}/element/active")
  end

  @doc "Send sequence of key strokes to active element. The modifier keys are not released after this command is run."
  @spec send_keys(Dict.t, String.t, List.t) :: :ok
  def send_keys(connection, session_id, keys) do
    make_req(connection, :post, "session/#{session_id}/keys", [value: keys])
  end
end
