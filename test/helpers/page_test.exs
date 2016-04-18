defmodule PageTest do
  use ExUnit.Case
  use Hound.Helpers

  alias Hound.Element

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
    assert Element.element?(find_element(:css, ".example"))
  end


  test "search_element/3 should return {:error, :no_such_element} if element does not exist" do
    navigate_to("http://localhost:9090/page1.html")
    assert search_element(:css, ".i-dont-exist") == {:error, :no_such_element}
  end

  test "find_element/3 should raise NoSuchElementError if element does not exist" do
    navigate_to("http://localhost:9090/page1.html")
    assert_raise Hound.NoSuchElementError, fn ->
      find_element(:css, ".i-dont-exist")
    end
  end

  test "should find all elements within page" do
    navigate_to("http://localhost:9090/page1.html")
    elements = find_all_elements(:tag, "p")
    assert length(elements) == 6
    for element <- elements do
      assert Element.element?(element)
    end
  end


  test "should find a single element within another element" do
    navigate_to("http://localhost:9090/page1.html")
    container_id = find_element(:class, "container")
    element = find_within_element(container_id, :class, "example")
    assert Element.element?(element)
  end

  test "search_within_element/4 should return {:error, :no_such_element} if element is not found" do
    navigate_to("http://localhost:9090/page1.html")
    container_id = find_element(:class, "container")
    assert search_within_element(container_id, :class, "i-dont-exist") == {:error, :no_such_element}
  end

  test "find_within_element/4 should raise NoSuchElementError if element is not found" do
    navigate_to("http://localhost:9090/page1.html")
    container_id = find_element(:class, "container")
    assert_raise Hound.NoSuchElementError, fn -> find_within_element(container_id, :class, "i-dont-exist") end
  end

  test "should find all elements within another element" do
    navigate_to("http://localhost:9090/page1.html")
    container_id = find_element(:class, "container")
    elements = find_all_within_element(container_id, :tag, "p")
    assert length(elements) == 2
    for element <- elements do
      assert Element.element?(element)
    end
  end


  test "should get element in focus" do
    navigate_to("http://localhost:9090/page1.html")
    assert Element.element?(element_in_focus())
  end


  test "should send text to active element" do
    navigate_to("http://localhost:9090/page1.html")
    click {:name, "username"}
    send_text "test"
    send_text "123"

    assert attribute_value({:name, "username"}, "value") == "test123"
  end

end
