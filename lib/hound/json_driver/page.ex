defmodule Hound.JsonDriver.Page do
  import Hound.JsonDriver.Utils

  @doc "Gets the HTML source of current page."
  @spec page_source() :: String.t
  def page_source() do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/source")
  end


  @doc "Gets the title of the current page."
  @spec page_title() :: String.t
  def page_title() do
    session_id = Hound.get_current_session_id
    make_req(:get, "session/#{session_id}/title")
  end


  @doc """
  Finds element on current page. It returns an element ID that can be used with other element functions.

  * The first argument is the strategy.
  * The second argument is the selector.

  Valid selector strategies are `:css`, `:class`, `:id`, `:name`, `:tag`, `:xpath`, `:link_text` and `:partial_link_text`

      find_element(:name, "username")
      find_element(:class, "example")
      find_element(:id, "example")
      find_element(:css, ".example")
      find_element(:tag, "footer")
      find_element(:link_text, "Home")
  """
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


  @doc """
  Finds elements on current page. Returns an array of element IDs that can be used with other element functions.

  * The first argument is the strategy.
  * The second argument is the selector.

  Valid selector strategies are `:css`, `:class`, `:id`, `:name`, `:tag`, `:xpath`, `:link_text` and `:partial_link_text`

      find_elements(:name, "username")
      find_elements(:class, "example")
      find_elements(:id, "example")
      find_elements(:css, ".example")
      find_elements(:tag, "footer")
      find_elements(:link_text, "Home")
  """
  @spec find_all_elements(atom, String.t) :: List.t
  def find_all_elements(strategy, selector) do
    session_id = Hound.get_current_session_id
    params = [using: Hound.InternalHelpers.selector_strategy(strategy), value: selector]
    case make_req(:post, "session/#{session_id}/elements", params) do
      {:error, value} ->
        {:error, value}
      elements ->
        Enum.map(elements, fn({"ELEMENT", element_id})->
          element_id
        end)
    end
  end


  @doc """
  Finds element within a specific element. Returns an element ID to use with element helper functions.

  * The first argument is the element ID of the element within which you want to search.
  * The second argument is the strategy.
  * The third argument is the selector.

  Valid selector strategies are `:css`, `:class`, `:id`, `:name`, `:tag`, `:xpath`, `:link_text` and `:partial_link_text`

      # First get an element ID to search within
      parent_element_id = find_element(:class, "container")

      find_within_element(parent_element_id, :name, "username")
      find_within_element(parent_element_id, :class, "example")
      find_within_element(parent_element_id, :id, "example")
      find_within_element(parent_element_id, :css, ".example")
      find_within_element(parent_element_id, :tag, "footer")
      find_within_element(parent_element_id, :link_text, "Home")
  """
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


  @doc """
  Finds elements within a specific element. Returns an array of element IDs that can be used with other element functions.

  * The first argument is the element ID of the element within which you want to search.
  * The second argument is the strategy.
  * The third argument is the selector.

  Valid selector strategies are `:css`, `:class`, `:id`, `:name`, `:tag`, `:xpath`, `:link_text` and `:partial_link_text`

      # First get an element ID to search within
      parent_element_id = find_element(:class, "container")

      find_all_within_element(parent_element_id, :name, "username")
      find_all_within_element(parent_element_id, :class, "example")
      find_all_within_element(parent_element_id, :id, "example")
      find_all_within_element(parent_element_id, :css, ".example")
      find_all_within_element(parent_element_id, :tag, "footer")
      find_all_within_element(parent_element_id, :link_text, "Home")
  """
  @spec find_all_within_element(String.t, atom, String.t) :: List.t
  def find_all_within_element(element_id, strategy, selector) do
    session_id = Hound.get_current_session_id
    params = [using: Hound.InternalHelpers.selector_strategy(strategy), value: selector]
    case make_req(:post, "session/#{session_id}/element/#{element_id}/elements", params) do
      {:error, value} ->
        {:error, value}
      elements ->
        Enum.map(elements, fn({"ELEMENT", element_id})->
          element_id
        end)
    end
  end


  @doc "Gets element on page that is currently in focus."
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


  @doc """
  Holds on to the spcified modifier keys when the block is executing.

      # Simulates Ctrl + e
      with_keys :control do
        send_text "e"
      end

      # Simulates Ctrl + Shift + e
      with_keys [:control, :shift] do
        send_text "e"
      end

  The following are the modifier keys:

  * :alt - alt key
  * :shift - shift key
  * :command - command key (or meta key)
  * :control - control key
  * :escape - escape key
  """
  defmacro with_keys(keys, blocks) do
    do_block = Keyword.get(blocks, :do, nil)
    quote do
      send_keys(unquote(keys))
      unquote(do_block)
      send_keys(:null)
    end
  end


  @doc """
  Send sequence of key strokes to active element.
  The keys are accepted as a list of atoms.

      send_keys :backspace
      send_keys :tab

  If you send the modifier keys shift, control, alt and command,
  they are held on and not released until you send the `:null` key.

  To perform other actions while holding on to modifier keys, use the `with_keys` macro.

  The following are the atoms representing the keys:

  * :alt - alt key
  * :shift - shift key
  * :command - command key (or meta key)
  * :control - control key
  * :escape - escape key
  * :backspace - backspace key
  * :tab - tab key
  * :clear - clear
  * :return - return key
  * :enter - enter key
  * :cancel - cancel key
  * :help - help key
  * :pause - pause key
  * :num0 - numpad 0
  * :num1 - numpad 1
  * :num2 - numpad 2
  * :num3 - numpad 3
  * :num4 - numpad 4
  * :num5 - numpad 5
  * :num6 - numpad 6
  * :num7 - numpad 7
  * :num8 - numpad 8
  * :num9 - numpad 9
  * :add - add key
  * :subtract - subtract key
  * :multiply - multiply key
  * :divide - divide key
  * :seperator - seperator key
  """
  @spec send_keys(List.t | atom) :: :ok
  def send_keys(keys) do
    if is_atom(keys), do: keys = [keys]
    session_id = Hound.get_current_session_id
    make_req(:post,
      "session/#{session_id}/keys",
      Hound.InternalHelpers.key_codes_json(keys),
      [json_encode: false])
  end


  @doc """
  Send character keys to active element.

      send_text "test"
      send_text "whatever happens"

  To send key strokes like tab, enter, etc, take a look at `send_keys`.
  """
  @spec send_text(String.t) :: :ok
  def send_text(keys) do
    session_id = Hound.get_current_session_id
    make_req(:post, "session/#{session_id}/keys", [value: [keys]])
  end
end
