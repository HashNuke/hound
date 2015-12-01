defmodule MatcherTests do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  #visible_text_in_page?
  test "should return true when text is visible" do
    navigate_to "http://localhost:9090/page1.html"
    assert visible_in_page?(~r/Paragraph/)
  end


  test "should return true when text is loaded by javascript" do
    navigate_to "http://localhost:9090/page1.html"
    :timer.sleep(1000)
    assert visible_in_page?(~r/Javascript/)
  end


  test "should *not* return true when text is not visible" do
    navigate_to "http://localhost:9090/page1.html"
    assert visible_in_page?(~r/hidden/) == false
  end


  # visible_text_in_element?
  test "should return true when text is visible inside block" do
    navigate_to "http://localhost:9090/page1.html"
    assert visible_in_element?({:class, "container"}, ~r/Another Paragraph/)
  end


  test "should return true when text is loaded by javascript inside block" do
    navigate_to "http://localhost:9090/page1.html"
    :timer.sleep(1000)
    assert visible_in_element?({:id, "javascript"}, ~r/Javascript/)
  end

  test "should *not* return true when text is not visible inside element" do
    navigate_to "http://localhost:9090/page1.html"
    assert visible_in_element?({:class, "hidden-wrapper"}, ~r/hidden/) == false
  end
end
