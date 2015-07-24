defmodule Hound.Matchers.Text do
  @moduledoc "Matchers to work with page text"

  import Hound.RequestUtils
  import Hound.Helpers.Page

  @type text :: String.t
  @type retries :: Integer.t
  @type selector  :: String.t

  @retry_time Application.get_env(:hound, :retry_time, 250)

  @doc """
  Returns true if text is found on the page.

  visible_on_page?("Paragraph")
  visible_on_page?("Paragraph", 4)

  The text is matched case-sensitive.
  """
  @spec visible_on_page?(text, retries) :: Boolean.t
  def visible_on_page?(text, retries \\ 5) do
    selector = {:general, nil}
    if retries > 0 do
      case is_on_page_within?(text, selector, retries) do
        true -> true
        false ->
          :timer.sleep(@retry_time)
          visible_on_page?(text, retries - 1)
      end
    else
      is_on_page_within?(text, selector, retries)
    end
  end

  @doc """
  Returns true if text is found on the page inside an element.

  visible_on_page_within?({:class, "block"}, "Paragraph")
  visible_on_page_within?({:id, "id"}, "Paragraph")
  visible_on_page_within?({:id, "id"}, "Paragraph", 5)

  The text is matched case-sensitive.
  """
  @spec visible_on_page_within?(selector, text, retries) :: Boolean.t
  def visible_on_page_within?(text, selector, retries \\ 5) do
    if retries > 0 do
      case is_on_page_within?(text, selector, retries) do
        true -> true
        false ->
          :timer.sleep(@retry_time)
          visible_on_page_within?(text, selector, retries - 1)
      end
    else
      is_on_page_within?(text, selector, retries)
    end
  end


  defp is_on_page_within?(selector, text, retries) do
    try do
      xpath_string = query(text, selector)
      element_id = find_element(:xpath, xpath_string, retries)
      session_id = Hound.current_session_id
      request = make_req(:get, "session/#{session_id}/element/#{element_id}/text", retries)
      String.length(request) > 1
    catch error ->
      false
    rescue error ->
      false
    end
  end

  defp query(text, {:general, _}) do
    "//*[contains(text(), '#{text}') or @value = '#{text}']"
  end

  defp query(text, {:class, selector}) do
    "//*[contains(concat(' ', normalize-space(@class), ' '), ' #{selector} ')]//*[contains(text(), '#{text}')]"
  end

  defp query(text, {:id, selector}) do
    "//*[@id='#{selector}' and contains(text(), '#{text}')]"
  end
end
