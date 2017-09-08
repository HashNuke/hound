defmodule Hound.Browser do
  @moduledoc "Low level functions to customize browser behavior"

  @type t :: Hound.BrowserLike.t

  @callback default_user_agent :: String.t | atom

  @callback default_capabilities(String.t) :: map

  @doc "Creates capabilities for the browser and options, to be sent to the webdriver"
  @spec make_capabilities(t, map | Keyword.t) :: map
  def make_capabilities(browser_name, opts \\ []) do
    browser = browser(browser_name)

    user_agent =
      user_agent(opts[:user_agent] || browser.default_user_agent)
      |> Hound.Metadata.append(opts[:metadata])

    capabilities = %{browserName: browser_name}
    default_capabilities = browser.default_capabilities(user_agent)
    additional_capabilities = opts[:additional_capabilities] || %{}

    capabilities
    |> Map.merge(default_capabilities)
    |> Map.merge(additional_capabilities)
  end

  @doc "Returns a user agent string"
  @spec user_agent(String.t | atom) :: String.t
  def user_agent(ua) when is_binary(ua), do: ua

  # bundle a few common user agents
  def user_agent(:firefox_desktop) do
    "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1"
  end
  def user_agent(:phantomjs) do
    "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/538.1 (KHTML, like Gecko) PhantomJS/2.1.1 Safari/538.1"
  end
  def user_agent(:chrome_desktop) do
    "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
  end
  def user_agent(:chrome_android_sp) do
    "Mozilla/5.0 (Linux; U; Android-4.0.3; en-us; Galaxy Nexus Build/IML74K) AppleWebKit/535.7 (KHTML, like Gecko) CrMo/16.0.912.75 Mobile Safari/535.7"
  end
  def user_agent(:chrome_iphone) do
    "Mozilla/5.0 (iPhone; U; CPU iPhone OS 5_1_1 like Mac OS X; en) AppleWebKit/534.46.0 (KHTML, like Gecko) CriOS/19.0.1084.60 Mobile/9B206 Safari/7534.48.3"
  end
  def user_agent(:safari_iphone) do
    "Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25"
  end
  def user_agent(:default) do
    ""
  end

  # add some simpler aliases
  def user_agent(:chrome),  do: user_agent(:chrome_desktop)
  def user_agent(:firefox), do: user_agent(:firefox_desktop)
  def user_agent(:android), do: user_agent(:chrome_android_sp)
  def user_agent(:iphone),  do: user_agent(:safari_iphone)

  defp browser(browser) when is_atom(browser) do
    browser |> Atom.to_string |> browser()
  end
  defp browser("firefox"),          do: Hound.Browser.Firefox
  defp browser("chrome"),           do: Hound.Browser.Chrome
  defp browser("chrome_headless"),  do: Hound.Browser.ChromeHeadless
  defp browser("phantomjs"),        do: Hound.Browser.PhantomJS
  defp browser(_),                  do: Hound.Browser.Default
end
