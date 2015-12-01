defmodule Hound.Matchers do
  @moduledoc "Text and element matchers"

  import Hound.Helpers.Page
  import Hound.Helpers.Element

  @type element_selector :: {atom, String.t}
  @type element :: element_selector | String.t


  @doc """
  Returns true if text is found on the page.

  visible_in_page?(~r/Paragraph/)
  """
  @spec visible_in_page?(Regex.t) :: Boolean.t
  def visible_in_page?(pattern) do
    inner_text = {:tag, "body"}
    |> attribute_value("innerText")

    Regex.match?(pattern, inner_text)
  end


  @doc """
  Returns true if text is found on the page inside an element.

  visible_in_element?({:class, "block"}, ~r/Paragraph/)
  visible_in_element?({:id, "foo"}, ~r/paragraph/iu)

  If the element matching the selector itself is a hidden element,
  then the match will return true even if the text is not hidden.
  """
  @spec visible_in_element?(element, Regex.t) :: Boolean.t
  def visible_in_element?(selector, pattern) do
    inner_text = attribute_value(selector, "innerText")
    Regex.match?(pattern, inner_text)
  end

end
