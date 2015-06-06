defmodule Hound.Helpers.Navigation do
  @moduledoc "Provides navigation functions."

  import Hound.InternalHelpers

  @doc "Gets url of the current page."
  @spec current_url :: String.t
  def current_url do
    {:ok, driver_info} = Hound.driver_info
    delegate_to_module driver_info[:driver_type], Navigation, :current_url
  end


  @doc """
  Navigates to a url or relative path.

      navigate_to("http://example.com/page1")
      navigate_to("/page1")
  """
  @spec navigate_to(String.t) :: :ok
  def navigate_to(url) do
    {:ok, driver_info} = Hound.driver_info

    final_url = generate_final_url(url)
    delegate_to_module driver_info[:driver_type], Navigation, :navigate_to, [final_url]
  end


  @doc "Navigates forward in browser history."
  @spec navigate_forward :: :ok
  def navigate_forward do
    {:ok, driver_info} = Hound.driver_info
    delegate_to_module driver_info[:driver_type], Navigation, :navigate_forward
  end


  @doc "Navigates back in browser history."
  @spec navigate_back() :: :ok
  def navigate_back do
    {:ok, driver_info} = Hound.driver_info
    delegate_to_module driver_info[:driver_type], Navigation, :navigate_back
  end


  @doc "Refreshes the current page."
  @spec refresh_page() :: :ok
  def refresh_page do
    {:ok, driver_info} = Hound.driver_info
    delegate_to_module driver_info[:driver_type], Navigation, :refresh_page
  end


  defp generate_final_url(url) do
    {:ok, configs} = Hound.configs

    if relative_path?(url) do
      "#{configs[:host]}:#{configs[:port]}#{url}"
    else
      url
    end
  end

  defp relative_path?(url) do
    String.starts_with?(url, "/")
  end

end
