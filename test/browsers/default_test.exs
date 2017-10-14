defmodule Hound.Browser.DefaultTest do
  use ExUnit.Case

  alias Hound.Browser.Default

  test "default_user_agent" do
    assert Default.default_user_agent == :default
  end

  test "default_capabilities" do
    ua = Hound.Browser.user_agent(:iphone)
    assert Default.default_capabilities(ua) == %{}
  end
end
