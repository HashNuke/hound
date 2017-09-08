defmodule Hound.Browser.Default do
  @moduledoc false

  @behaviour Hound.Browser

  def default_user_agent, do: :default

  def default_capabilities(_ua), do: %{}
end
