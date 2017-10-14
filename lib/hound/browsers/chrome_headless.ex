defmodule Hound.Browser.ChromeHeadless do
  @moduledoc false

  @behaviour Hound.Browser

  def default_user_agent, do: :chrome

  def default_capabilities(ua) do
    %{chromeOptions: %{"args" => ["--user-agent=#{ua}", "--headless", "--disable-gpu"]}}        
  end
end
