defmodule Hound.Browser.ChromeTest do
  use ExUnit.Case

  alias Hound.Browser.Chrome

  test "default_user_agent" do
    assert Chrome.default_user_agent == :chrome
  end

  test "default_capabilities" do
    ua = Hound.Browser.user_agent(:iphone)
    expected = %{chromeOptions: %{"args" => ["--user-agent=#{ua}"]}}
    assert Chrome.default_capabilities(ua) == expected
  end
end
