defmodule ElementWithSelectorsTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "should get visible text of an element, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    assert visible_text({:class, "example"}) == "Paragraph"
  end


  test "should input value into field, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"

    element = {:name, "username"}

    input_into_field(element, "john")
    assert attribute_value(element, "value") == "john"

    input_into_field(element, "doe")
    assert attribute_value(element, "value") == "johndoe"
  end


  test "should fill a field with a value, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    element = {:name, "username"}

    fill_field(element, "johndoe")
    assert attribute_value(element, "value") == "johndoe"

    fill_field(element, "janedoe")
    assert attribute_value(element, "value") == "janedoe"
  end


  test "should get tag name of element, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    assert tag_name({:name, "username"}) == "input"
  end


  test "should clear field, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    element = {:name, "username"}

    fill_field(element, "johndoe")
    assert attribute_value(element, "value") == "johndoe"

    clear_field(element)
    assert attribute_value(element, "value") == ""
  end


  test "should return true if item is selected in a checkbox or radio, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    element = {:id, "speed-superpower"}
    click element
    assert selected?(element)
  end


  test "should return false if item is *not* selected, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    assert selected?({:id, "speed-flying"}) == false
  end


  test "Should return true if element is enabled, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    assert element_enabled?({:name, "username"}) == true
  end


  test "Should return false if element is *not* enabled, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    assert element_enabled?({:name, "promocode"}) == false
  end


  test "should get attribute value of an element, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    assert attribute_value({:class, "example"}, "data-greeting") == "hello"
  end


  test "should return true when an element has a class, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    assert has_class?({:class, "example"}, "example")
    assert has_class?({:class, "another_example"}, "another_class")
  end


  test "should return false when an element does not have a class, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    refute has_class?({:class, "example"}, "ex")
    refute has_class?({:class, "example"}, "other")
  end


  test "should return true if an element is displayed, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    assert element_displayed?({:class, "example"})
  end


  test "should return false if an element is *not* displayed, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    assert element_displayed?({:class, "hidden-element"}) == false
  end


  test "should get an element's location on screen, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    {loc_x, loc_y} = element_location({:class, "example"})
    assert is_integer(loc_x) || is_float(loc_x)
    assert is_integer(loc_y) || is_float(loc_y)
  end


  test "should get an element's size, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    size = element_size({:class, "example"})
    assert size == {400, 100}
  end


  test "should get css property of an element, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    assert css_property({:class, "container"}, "display") == "block"
  end


  test "should click on an element, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    click({:class, "submit-form"})
    assert current_url == "http://localhost:9090/page2.html"
  end


  test "should submit a form element, when selector is passed" do
    navigate_to "http://localhost:9090/page1.html"
    submit_element({:name, "username"})
    assert current_url == "http://localhost:9090/page2.html"
  end
end
