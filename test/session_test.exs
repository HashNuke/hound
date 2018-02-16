defmodule Hound.SessionTest do
  use ExUnit.Case

  alias Hound.Session

  test "make_capabilities uses default browser" do
    assert %{browserName: "chrome"} = Session.make_capabilities("chrome")
  end

  test "make_capabilities has default settings" do
    assert %{takesScreenshot: true} = Session.make_capabilities("chrome")
  end

  test "make_capabilities allows browser override" do
    assert %{browserName: "firefox"} = Session.make_capabilities("chrome", browser: "firefox")
  end

  test "make_capabilities uses driver overrides" do
    assert %{foo: "bar"} = Session.make_capabilities("chrome", driver: %{foo: "bar"})
  end

  test "make_capabilities overrides user agent" do
    ua = Hound.Browser.user_agent(:chrome)
    result = Session.make_capabilities("chrome", user_agent: ua)
    assert %{chromeOptions: %{"args" => ["--user-agent=" <> ^ua]}} = result
  end

  test "make_capabilities deep merges chromeOptions" do
    %{chromeOptions: resulting_options} =
      Session.make_capabilities(
        "chrome_headless",
        driver: %{
          chromeOptions: %{
            "args" => [
              "--window-size=1920x1080"
            ]
          }
        }
      )

    %{chromeOptions: %{"args" => default_args}} =
      Hound.Browser.make_capabilities("chrome_headless")

    assert resulting_options == %{"args" => default_args ++ ["--window-size=1920x1080"]}
  end
end
