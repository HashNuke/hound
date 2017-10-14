defmodule Hound.Browser.PhantomJS do
  @moduledoc false

  @behaviour Hound.Browser

  def default_user_agent, do: :phantomjs

  def default_capabilities(ua) do
    %{"phantomjs.page.settings.userAgent" => ua}
  end
end
