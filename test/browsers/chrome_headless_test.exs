defmodule Hound.Browser.ChromeHeadlessTest do
  use ExUnit.Case

  alias Hound.Browser.ChromeHeadless

  test "default_user_agent" do
    assert ChromeHeadless.default_user_agent == :chrome
  end

  test "default_capabilities" do
    ua = Hound.Browser.user_agent(:iphone)
    expected = %{chromeOptions: %{"args" => ["--user-agent=#{ua}", "--headless", "--disable-gpu"]}}
    assert ChromeHeadless.default_capabilities(ua) == expected
  end
end
