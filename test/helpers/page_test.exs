defmodule PageTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "should get page source" do
    navigate_to("http://localhost:9090/page1.html")
    assert(Regex.match?(~r/DOCTYPE/, page_source))
  end

  test "should get visible page text" do
    navigate_to("http://localhost:9090/page1.html")
    assert(String.contains? visible_page_text, "Flying")
    assert(not String.contains? visible_page_text, "This is hidden")
  end


  test "should get page title" do
    navigate_to("http://localhost:9090/page1.html")
    assert("Hound Test Page" == page_title)
  end


  test "should get page title encoded with utf8" do
    navigate_to("http://localhost:9090/page_utf.html")
    assert("This is UTF: zażółć gęślą jaźń" == page_title)
  end


  test "should find element within page" do
    navigate_to("http://localhost:9090/page1.html")
    assert is_binary(find_element(:css, ".example"))
  end


  test "should find all elements within page" do
    navigate_to("http://localhost:9090/page1.html")
    element_ids = find_all_elements(:tag, "p")
    assert length(element_ids) == 5
    for element_id <- element_ids do
      assert is_binary(element_id)
    end
  end


  test "should find a single element within another element" do
    navigate_to("http://localhost:9090/page1.html")
    container_id = find_element(:class, "container")
    element = find_within_element(container_id, :class, "example")
    assert is_binary(element)
  end


  test "should find all elements within another element" do
    navigate_to("http://localhost:9090/page1.html")
    container_id = find_element(:class, "container")
    element_ids = find_all_within_element(container_id, :tag, "p")
    assert length(element_ids) == 2
    for element_id <- element_ids do
      assert is_binary(element_id)
    end
  end


  test "should get element in focus" do
    navigate_to("http://localhost:9090/page1.html")
    assert is_binary(element_in_focus())
  end


  test "should send text to active element" do
    navigate_to("http://localhost:9090/page1.html")
    click {:name, "username"}
    send_text "test"
    send_text "123"

    assert attribute_value({:name, "username"}, "value") == "test123"
  end

end
