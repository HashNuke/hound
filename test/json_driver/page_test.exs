defmodule PageTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "should get page source" do
    navigate_to("http://localhost:9090/page1.html")
    assert(Regex.match?(%r/DOCTYPE/, page_source))
  end


  test "should get page title" do
    navigate_to("http://localhost:9090/page1.html")
    assert("Hound Test Page" == page_title)
  end


  # test "should find elements within page" do
  # end


  # test "should find single element within page" do
  # end


  # test "should find single element within another element" do
  # end


  # test "should find elements within another element" do
  # end


  # test "should get element in focus" do
  # end


  # test "should send keys" do
  #   # Show copy paste example.
  #   # Use cmd modifier on mac and ctrl on others.
  # end

end
