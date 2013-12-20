defmodule MultipleBrowserSessionTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "should be able to run multiple sessions" do
    url1 = "http://localhost:9090/page1.html"
    url2 = "http://localhost:9090/page2.html"

    # Navigate to a url
    navigate_to(url1)

    # Change to another session
    Hound.change_session_to :another_session
    # Navigate to a url in the second session
    navigate_to(url2)
    # Then assert url
    assert url2 == current_url

    # Now go back to the default session
    Hound.change_to_default_session
    # Assert if the url is the one we visited
    assert url1 == current_url    
  end

end
