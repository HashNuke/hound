defmodule TextMatcherTests do
  use ExUnit.Case
  use Hound.Helpers
  use Hound.Matchers

  hound_session

  #visible_on_page?
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
    assert !visible_on_page?("hidden", 1)
  end

  # visible_on_page_within?
  test "should return true when text is visible inside block" do
    navigate_to "http://localhost:9090/page1.html"
    assert visible_on_page_within?({:class, "container"}, "Another Paragraph")
  end

  test "should return true when text is loaded by javascript inside block" do
    navigate_to "http://localhost:9090/page1.html"
    assert visible_on_page_within?({:id, "javascript"}, "Javascript!")
  end

  test "should return false when text is not visible inside block" do
    navigate_to "http://localhost:9090/page1.html"
    assert !visible_on_page_within?({:class, "container"}, "hidden", 1)
  end
end
