defmodule Hound.Matchers.Text do
  @moduledoc "Matchers to work with page text"

  import Hound.RequestUtils
  import Hound.Helpers.Page

  @type text :: String.t
  @type retries :: Integer.t

  @doc """
  Returns true if text is found on the page.

  visible_on_page?("Paragraph")

  The text is matched case-sensitive.
  """
  @spec visible_on_page?(text, retries) :: Boolean.t
  def visible_on_page?(text, retries \\ 5) do
    if retries > 0 do
      case is_on_page?(text, retries) do
        true -> true
        false ->
          :timer.sleep(500)
          visible_on_page?(text, retries - 1)
      end
    else
      is_on_page?(text, retries)
    end
  end

  defp is_on_page?(text, retries) do
    xpath_string =  "//*[contains(text(), '#{text}')]"
    element_id = find_element(:xpath, xpath_string, retries)
    session_id = Hound.current_session_id
    request = make_req(:get, "session/#{session_id}/element/#{element_id}/text", retries)
    String.length(request) > 1
  end
end
