defmodule Hound.BrowserTest do
  use ExUnit.Case

  alias Hound.Browser

  test "make_capabilities for chrome" do
    result = Browser.make_capabilities("chrome", metadata: %{"foo" => "bar"})
    assert %{browserName: "chrome", chromeOptions: %{"args" => ["--user-agent=" <> ua]}} = result
    assert Hound.Metadata.extract(ua) == %{"foo" => "bar"}
  end

  test "make capabilities for firefox" do
    result = Browser.make_capabilities("firefox", metadata: %{"foo" => "bar"})
    assert %{:browserName => "firefox", "firefox_profile" => profile} = result
    assert {:ok, files} = :zip.extract(Base.decode64!(profile), [:memory])
    assert [{'user.js', user_prefs}] = files
    assert [_, ua] = Regex.run(~r{user_pref\("general\.useragent\.override", "(.*?)"\);}, user_prefs)
    assert Hound.Metadata.extract(ua) == %{"foo" => "bar"}
  end

  test "make_capabilities for phantomjs" do
    result = Browser.make_capabilities("phantomjs", metadata: %{"foo" => "bar"})
    assert %{:browserName => "phantomjs", "phantomjs.page.settings.userAgent" => ua} = result
    assert Hound.Metadata.extract(ua) == %{"foo" => "bar"}
  end

  test "user_agent" do
    assert Browser.user_agent(:firefox)   =~ "Firefox"
    assert Browser.user_agent(:chrome)    =~ "Chrome"
    assert Browser.user_agent(:iphone)    =~ "iPhone"
    assert Browser.user_agent(:android)   =~ "Android"
    assert Browser.user_agent(:phantomjs) =~ "PhantomJS"
  end

  test "make_capabilities supports additional_capabilities" do
    result = Browser.make_capabilities("firefox", additional_capabilities: %{firefox_profile: :firefox_profile})
    assert %{browserName: "firefox", firefox_profile: :firefox_profile} = result
  end
end
