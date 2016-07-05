defmodule Hound.Browser.DefaultTest do
  use ExUnit.Case

  alias Hound.Browser.Default

  test "default_user_agent" do
    assert Default.default_user_agent == :default
  end

  test "user_agent_capabilities" do
    ua = Hound.Browser.user_agent(:iphone)
    assert Default.user_agent_capabilities(ua) == %{}
  end
end
