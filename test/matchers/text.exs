defmodule MatcherTests do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  #visible_on_page?
  test "should return true when text is visible" do
    navigate_to "http://localhost:9090/page1.html"
    assert visible_text?("Paragraph")
  end


  test "should return true when text is loaded by javascript" do
    navigate_to "http://localhost:9090/page1.html"
    assert visible_text?("Javascript!")
  end


  test "should return false when text is not visible" do
    navigate_to "http://localhost:9090/page1.html"
    assert !visible_text?("hidden", 1)
  end


  # visible_on_page_within?
  test "should return true when text is visible inside block" do
    navigate_to "http://localhost:9090/page1.html"
    assert visible_text_within?({:class, "container"}, "Another Paragraph")
  end


  test "should return true when text is loaded by javascript inside block" do
    navigate_to "http://localhost:9090/page1.html"
    assert visible_text_within?({:id, "javascript"}, "Javascript!")
  end

  test "should return false when text is not visible inside block" do
    navigate_to "http://localhost:9090/page1.html"
    assert !visible_text_within?({:class, "container"}, "hidden", 1)
  end
end
