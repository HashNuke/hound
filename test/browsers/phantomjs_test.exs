defmodule Hound.Browser.PhantomJSTest do
  use ExUnit.Case

  alias Hound.Browser.PhantomJS

  test "default_user_agent" do
    assert PhantomJS.default_user_agent == :phantomjs
  end

  test "user_agent_capabilities" do
    ua = Hound.Browser.user_agent(:iphone)
    assert PhantomJS.user_agent_capabilities(ua) == %{"phantomjs.page.settings.userAgent" => ua}
  end
end
