defmodule Hound.Matchers do
  @moduledoc "Text and element matchers"

  import Hound.Helpers.Page

  @type text :: String.t
  @type selector :: String.t


  @doc """
  Returns true if text is found on the page.

  visible_text?("Paragraph")
  visible_text?("Paragraph")

  The text is matched case-sensitive.
  """
  @spec visible_text?(text) :: Boolean.t
  def visible_text?(text) do
    xpath_string = query(text)
    element_ids  = find_all_elements(:xpath, xpath_string)
    element_ids != []
  end


  @doc """
  Returns true if text is found on the page inside an element.

  visible_text_within?({:class, "block"}, "Paragraph")
  visible_text_within?({:id, "foo"}, "Paragraph")

  The text is matched case-sensitive.
  """
  @spec visible_text_within?(selector, text) :: Boolean.t
  def visible_text_within?(selector, text) do
    xpath_string = query(text, selector)
    element_ids  = find_all_elements(:xpath, xpath_string)
    element_ids != []
  end


  defp query(text) do
    "//*[contains(text(), '#{text}') or @value = '#{text}']"
  end

  defp query(text, {:class, selector}) do
    "//*[contains(concat(' ', normalize-space(@class), ' '), ' #{selector} ')]//*[contains(text(), '#{text}')]"
  end

  defp query(text, {:id, selector}) do
    "//*[@id='#{selector}' and contains(text(), '#{text}')]"
  end
end
