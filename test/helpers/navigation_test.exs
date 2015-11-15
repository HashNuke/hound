defmodule NavigationTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "should get current url" do
    url = "http://localhost:9090/page1.html"
    navigate_to(url)
    assert url == current_url
  end

  test "should get current path" do
    url = "http://localhost:9090/page1.html"
    navigate_to(url)
    assert current_path == "/page1.html"
  end

  test "should navigate to a url" do
    url = "http://localhost:9090/page1.html"

    navigate_to(url)
    assert( url == current_url )
  end


  test "should navigate to a relative url" do
    url = "http://localhost:9090/page1.html"

    navigate_to("/page1.html")
    assert url == current_url
  end

  test "should navigate backward, forward and refresh" do
    url1 = "http://localhost:9090/page1.html"
    url2 = "http://localhost:9090/page2.html"

    navigate_to(url1)
    assert( url1 == current_url )

    navigate_to(url2)
    assert( url2 == current_url )

    navigate_back()
    assert( url1 == current_url )

    navigate_forward()
    assert( url2 == current_url )

    refresh_page()
    assert( url2 == current_url )
  end

end
