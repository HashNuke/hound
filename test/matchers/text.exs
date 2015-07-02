defmodule TextMatcherTests do
  use ExUnit.Case
  use Hound.Helpers
  use Hound.Matchers

  hound_session

  test "should return true when text is visible" do
    navigate_to "http://localhost:9090/page1.html"
    assert visible_on_page?("Paragraph")
  end

  test "should return true when text is loaded by javascript" do
    navigate_to "http://localhost:9090/page1.html"
    assert visible_on_page?("Javascript!")
  end

  test "should return false when text is not visible" do
    navigate_to "http://localhost:9090/page1.html"
    assert !visible_on_page?("hidden")
  end
end
