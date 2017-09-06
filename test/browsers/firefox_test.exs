defmodule Hound.Browser.FirefoxTest do
  use ExUnit.Case

  alias Hound.Browser.Firefox

  test "default_user_agent" do
    assert Firefox.default_user_agent == :firefox
  end

  test "user_agent_capabilities" do
    ua = Hound.Browser.user_agent(:iphone)
    assert %{"firefox_profile" => profile} = Firefox.user_agent_capabilities(ua)
    assert {:ok, files} = :zip.extract(Base.decode64!(profile), [:memory])
    assert [{'user.js', user_prefs}] = files
    assert user_prefs =~ ~s<user_pref("general.useragent.override", "#{ua}");>
  end
end
