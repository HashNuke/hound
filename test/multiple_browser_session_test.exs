defmodule MultipleBrowserSessionTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "should be able to run multiple sessions" do
    first_session = Hound.start_session
    url1 = "http://localhost:9090/page1.html"
    url2 = "http://localhost:9090/page2.html"

    # Navigate to a url
    navigate_to(url1)

    # Change to another session
    Hound.start_session
    # Navigate to a url in the second session
    navigate_to(url2)
    # Then assert url
    assert url2 == current_url

    # Now go back to the original session
    change_session_to first_session
    # Assert if the url is the one we visited
    assert url1 == current_url
  end


  test "should be able to run multiple sessions using in_browser_session" do
    url1 = "http://localhost:9090/page1.html"
    url2 = "http://localhost:9090/page2.html"

    # Navigate to a url
    navigate_to(url1)

    # In another session...
    another_session = Hound.start_session
    perform_in_session another_session, fn->
      navigate_to(url2)
      assert url2 == current_url
    end

    # Assert if the url is the one we visited
    assert url1 == current_url
  end

  test "should preserve session after using in_browser_session" do
    default = Hound.start_session
    url1 = "http://localhost:9090/page1.html"
    url2 = "http://localhost:9090/page2.html"
    url3 = "http://localhost:9090/page3.html"

    # Navigate to url1 in default session
    navigate_to(url1)

    # Change to a second session and navigate to url2
    session_a = Hound.start_session
    change_session_to session_a
    navigate_to(url2)

    # In a third session...
    session_b = Hound.start_session
    perform_in_session session_b, fn ->
      navigate_to(url3)
      assert url3 == current_url
    end

    # Assert the current url is the url we visited in :session_a
    assert url2 == current_url

    # Switch back to the default session
    change_session_to default

    # Assert the current url is the one we visited in the default session
    assert url1 == current_url
  end

  test "in_browser_session should return the result of the given function" do
    url1 = "http://localhost:9090/page1.html"

    # In another session, navigate to url1 and return the current url
    another_session = Hound.start_session
    result =
      perform_in_session another_session, fn ->
        navigate_to(url1)
        current_url
      end

    assert result == url1
  end
end
