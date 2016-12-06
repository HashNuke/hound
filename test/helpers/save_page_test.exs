defmodule SavePageTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "should save the page" do
    navigate_to("http://localhost:9090/page1.html")
    path = save_page("screenshot-test.html")
    assert File.exists?(path)
  end

end
