defmodule Hound.JsonDriver.Page do
  import Hound.JsonDriver.Utils


  @spec page_source() :: String.t
  def page_source() do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/source")
  end


  @spec page_title() :: String.t
  def page_title() do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/title")
  end


  @spec find_element(String.t, String.t) :: Dict.t
  def find_element(strategy, selector) do
    session_id = Hound.current_session_id
    params = [using: Hound.InternalHelpers.selector_strategy(strategy), value: selector]
    case make_req(:post, "session/#{session_id}/element", params) do
      %{"ELEMENT" => element_id} ->
        element_id
      value ->
        value
    end
  end


  @spec find_all_elements(atom, String.t) :: List.t
  def find_all_elements(strategy, selector) do
    session_id = Hound.current_session_id
    params = [using: Hound.InternalHelpers.selector_strategy(strategy), value: selector]
    case make_req(:post, "session/#{session_id}/elements", params) do
      {:error, value} ->
        {:error, value}
      elements ->
        Enum.map(elements, fn(%{"ELEMENT" => element_id})->
          element_id
        end)
    end
  end


  @spec find_within_element(String.t, atom,String.t) :: Dict.t
  def find_within_element(element_id, strategy, selector) do
    session_id = Hound.current_session_id
    params = [using: Hound.InternalHelpers.selector_strategy(strategy), value: selector]
    case make_req(:post, "session/#{session_id}/element/#{element_id}/element", params) do
      [{"ELEMENT", element_id}] ->
        element_id
      value ->
        value
    end
  end


  @spec find_all_within_element(String.t, atom, String.t) :: List.t
  def find_all_within_element(element_id, strategy, selector) do
    session_id = Hound.current_session_id
    params = [using: Hound.InternalHelpers.selector_strategy(strategy), value: selector]
    case make_req(:post, "session/#{session_id}/element/#{element_id}/elements", params) do
      {:error, value} ->
        {:error, value}
      elements ->
        Enum.map(elements, fn(%{"ELEMENT" => element_id})->
          element_id
        end)
    end
  end


  @spec element_in_focus() :: Dict.t
  def element_in_focus do
    session_id = Hound.current_session_id
    case make_req(:post, "session/#{session_id}/element/active") do
      %{"ELEMENT" => element_id} ->
        element_id
      value ->
        value
    end
  end


  @spec send_keys(List.t | atom) :: :ok
  def send_keys(keys) do
    if is_atom(keys), do: keys = [keys]
    session_id = Hound.current_session_id
    make_req(:post,
      "session/#{session_id}/keys",
      Hound.InternalHelpers.key_codes_json(keys),
      [json_encode: false])
  end


  @spec send_text(String.t) :: :ok
  def send_text(keys) do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/keys", [value: [keys]])
  end
end
