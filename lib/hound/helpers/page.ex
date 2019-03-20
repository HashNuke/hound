defmodule Hound.Helpers.Page do
  @moduledoc "Provides element finders, form fillers and page-related functions"

  import Hound.RequestUtils

  @doc "Gets the HTML source of current page."
  @spec page_source() :: String.t
  def page_source do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/source")
  end

  @doc "Gets the visible text of current page."
  @spec visible_page_text() :: String.t
  def visible_page_text do
    element = find_element(:css, "body")
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/element/#{element}/text")
  end

  @doc "Gets the title of the current page."
  @spec page_title() :: String.t
  def page_title do
    session_id = Hound.current_session_id
    make_req(:get, "session/#{session_id}/title")
  end


  @doc """
  Finds element on current page. It returns an element that can be used with other element functions.

  * The first argument is the strategy.
  * The second argument is the selector.

  Valid selector strategies are `:css`, `:class`, `:id`, `:name`, `:tag`, `:xpath`, `:link_text` and `:partial_link_text`
  `raises` if the element is not found or an error happens.


      find_element(:name, "username")
      find_element(:class, "example")
      find_element(:id, "example")
      find_element(:css, ".example")
      find_element(:tag, "footer")
      find_element(:link_text, "Home")
  """
  @spec find_element(Hound.Element.strategy, String.t, non_neg_integer) :: Hound.Element.t
  def find_element(strategy, selector, retries \\ 5) do
    case search_element(strategy, selector, retries) do
      {:ok, element} -> element
      {:error, :no_such_element} ->
        raise Hound.NoSuchElementError, strategy: strategy, selector: selector
      {:error, err} ->
        raise Hound.Error, "could not get element {#{inspect(strategy)}, #{inspect(selector)}}: #{inspect(err)}"
    end
  end

  @doc """
  Same as `find_element/3`, but returns the a tuple with `{:error, error}` instead of raising
  """
  @spec search_element(Hound.Element.strategy, String.t, non_neg_integer) :: {:ok, Hound.Element.t} | {:error, any}
  def search_element(strategy, selector, retries \\ 5) do
    session_id = Hound.current_session_id
    params = %{using: Hound.InternalHelpers.selector_strategy(strategy), value: selector}

    make_req(:post, "session/#{session_id}/element", params, %{safe: true}, retries*2)
    |> process_element_response
  end


  @doc """
  Finds elements on current page. Returns an array of elements that can be used with other element functions.

  * The first argument is the strategy.
  * The second argument is the selector.

  Valid selector strategies are `:css`, `:class`, `:id`, `:name`, `:tag`, `:xpath`, `:link_text` and `:partial_link_text`

      find_all_elements(:name, "username")
      find_all_elements(:class, "example")
      find_all_elements(:id, "example")
      find_all_elements(:css, ".example")
      find_all_elements(:tag, "footer")
      find_all_elements(:link_text, "Home")
  """
  @spec find_all_elements(atom, String.t, non_neg_integer) :: list
  def find_all_elements(strategy, selector, retries \\ 5) do
    session_id = Hound.current_session_id
    params = %{using: Hound.InternalHelpers.selector_strategy(strategy), value: selector}

    case make_req(:post, "session/#{session_id}/elements", params, %{}, retries*2) do
      {:error, value} ->
        {:error, value}
      elements ->
        Enum.map(elements, &Hound.Element.from_response/1)
    end
  end


  @doc """
  Finds element within a specific element. Returns an element to use with element helper functions.

  * The first argument is the element within which you want to search.
  * The second argument is the strategy.
  * The third argument is the selector.

  Valid selector strategies are `:css`, `:class`, `:id`, `:name`, `:tag`, `:xpath`, `:link_text` and `:partial_link_text`

      # First get an element to search within
      parent_element = find_element(:class, "container")

      find_within_element(parent_element, :name, "username")
      find_within_element(parent_element, :class, "example")
      find_within_element(parent_element, :id, "example")
      find_within_element(parent_element, :css, ".example")
      find_within_element(parent_element, :tag, "footer")
      find_within_element(parent_element, :link_text, "Home")
  """
  @spec find_within_element(Hound.Element.t, Hound.Element.strategy, String.t, non_neg_integer) :: Hound.Element.t
  def find_within_element(element, strategy, selector, retries \\ 5) do
    case search_within_element(element, strategy, selector, retries) do
      {:error, :no_such_element} ->
        raise Hound.NoSuchElementError, strategy: strategy, selector: selector, parent: element
      {:error, err} ->
        raise Hound.Error, "could not get element {#{inspect(strategy)}, #{inspect(selector)}} in #{element}: #{inspect(err)}"
      {:ok, element} -> element
    end
  end

  @doc """
  Same as `find_within_element/4`, but returns a `{:error, err}` tuple instead of raising
  """
  @spec search_within_element(Hound.Element.t, Hound.Element.strategy, String.t, non_neg_integer) :: {:ok, Hound.Element.t} | {:error, any}
  def search_within_element(element, strategy, selector, retries \\ 5) do
    session_id = Hound.current_session_id
    params = %{using: Hound.InternalHelpers.selector_strategy(strategy), value: selector}

    make_req(:post, "session/#{session_id}/element/#{element}/element", params, %{safe: true}, retries*2)
    |> process_element_response
  end


  @doc """
  Finds elements within a specific element. Returns an array of elements that can be used with other element functions.

  * The first argument is the element within which you want to search.
  * The second argument is the strategy.
  * The third argument is the selector.

  Valid selector strategies are `:css`, `:class`, `:id`, `:name`, `:tag`, `:xpath`, `:link_text` and `:partial_link_text`

      # First get an element to search within
      parent_element = find_element(:class, "container")

      find_all_within_element(parent_element, :name, "username")
      find_all_within_element(parent_element, :class, "example")
      find_all_within_element(parent_element, :id, "example")
      find_all_within_element(parent_element, :css, ".example")
      find_all_within_element(parent_element, :tag, "footer")
      find_all_within_element(parent_element, :link_text, "Home")
  """
  @spec find_all_within_element(Hound.Element.t, atom, String.t, non_neg_integer) :: list
  def find_all_within_element(element, strategy, selector, retries \\ 5) do
    session_id = Hound.current_session_id
    params = %{using: Hound.InternalHelpers.selector_strategy(strategy), value: selector}

    case make_req(:post, "session/#{session_id}/element/#{element}/elements", params, %{}, retries*2) do
      {:error, value} ->
        {:error, value}
      elements ->
        Enum.map(elements, &Hound.Element.from_response/1)
    end
  end


  @doc "Gets element on page that is currently in focus."
  @spec element_in_focus() :: map
  def element_in_focus do
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/element/active")
    |> Hound.Element.from_response
  end


  @doc """
  Holds on to the specified modifier keys when the block is executing.

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
  @spec send_keys(list | atom) :: :ok
  def send_keys(keys) when is_atom(keys) or is_list(keys) do
    keys = List.wrap(keys)
    session_id = Hound.current_session_id
    make_req(:post,
      "session/#{session_id}/keys",
      Hound.InternalHelpers.key_codes_json(keys),
      %{json_encode: false})
  end


  @doc """
  Send character keys to active element.

      send_text "test"
      send_text "whatever happens"

  To send key strokes like tab, enter, etc, take a look at `send_keys`.
  """
  @spec send_text(String.t) :: :ok
  def send_text(keys) do
    session_id = Hound.current_session_id
    %Hound.Element{uuid: uuid} = element_in_focus()
    make_req(:post, "session/#{session_id}/element/#{uuid}/value", %{value: [keys]})
  end

  defp process_element_response(%{"ELEMENT" => element_id}),
    do: {:ok, %Hound.Element{uuid: element_id}}
  defp process_element_response(%{"element-6066-11e4-a52e-4f735466cecf" => element_id}),
    do: {:ok, %Hound.Element{uuid: element_id}}
  defp process_element_response({:error, _err} = error),
    do: error
  defp process_element_response(unknown_error),
    do: {:error, unknown_error}
end
