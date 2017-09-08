defmodule Hound.Browser.Firefox do
  @moduledoc false

  @behaviour Hound.Browser

  alias Hound.Browser.Firefox.Profile

  def default_user_agent, do: :firefox

  def default_capabilities(ua) do
    {:ok, profile} = Profile.new |> Profile.set_user_agent(ua) |> Profile.dump
    %{firefox_profile: profile}
  end
end
