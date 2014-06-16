defmodule Hound.Helpers.Navigation do
  @moduledoc "Provides navigation functions."

  @doc "Gets url of the current page."
  @spec current_url :: String.t
  def current_url do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Navigation.current_url
  end


  @doc """
  Navigates to a url.

      navigate_to("http://example.com")
  """
  @spec navigate_to(String.t) :: :ok
  def navigate_to(url) do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Navigation.navigate_to(url)
  end


  @doc "Navigates forward in browser history."
  @spec navigate_forward :: :ok
  def navigate_forward do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Navigation.navigate_forward
  end


  @doc "Navigates back in browser history."
  @spec navigate_back() :: :ok
  def navigate_back do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Navigation.navigate_back
  end


  @doc "Refreshes the current page."
  @spec refresh_page() :: :ok
  def refresh_page do
    {:ok, driver_info} = Hound.driver_info
    driver_info[:driver_type].Navigation.refresh_page
  end

end
