defmodule Hound.Matchers do
  @moduledoc "Text and element matchers"

  import Hound.Helpers.Page
  import Hound.Helpers.Element

  @doc """
  Returns true if text is found on the page.

      visible_in_page?(~r/Paragraph/)
  """
  @spec visible_in_page?(Regex.t) :: boolean
  def visible_in_page?(pattern) do
    text = inner_text({:tag, "body"})
    Regex.match?(pattern, text)
  end


  @doc """
  Returns true if text is found on the page inside an element.

      visible_in_element?({:class, "block"}, ~r/Paragraph/)
      visible_in_element?({:id, "foo"}, ~r/paragraph/iu)

  If the element matching the selector itself is a hidden element,
  then the match will return true even if the text is not hidden.
  """
  @spec visible_in_element?(Hound.Element.selector, Regex.t) :: boolean
  def visible_in_element?(selector, pattern) do
    text = inner_text(selector)
    Regex.match?(pattern, text)
  end


  @doc """
  Returns true if an element is present.

      element?(:class, "block")
      element?(:id, "foo")
  """
  @spec element?(Hound.Element.strategy, String.t) :: boolean
  def element?(strategy, selector) do
    find_all_elements(strategy, selector) != []
  end
end
