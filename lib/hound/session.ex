defmodule Hound.Session do
  @moduledoc "Low-level session functions internally used by Hound, to work with drivers. See Hound.Helpers.Session for session helpers"

  import Hound.RequestUtils

  @doc "Get server's current status"
  @spec server_status() :: map
  def server_status() do
    make_req(:get, "status")
  end


  @doc "Get list of active sessions"
  @spec active_sessions() :: map
  def active_sessions() do
    make_req(:get, "sessions")
  end


  @doc "Creates a session associated with the current pid"
  @spec create_session(Hound.Browser.t, map | Keyword.t) :: {:ok, String.t}
  def create_session(browser, opts) do
    capabilities = make_capabilities(browser, opts)
    params = %{
      desiredCapabilities: capabilities
    }

    # No retries for this request
    make_req(:post, "session", params)
  end

  @doc "Make capabilities for session"
  @spec make_capabilities(Hound.Browser.t, map | Keyword.t) :: map
  def make_capabilities(browser, opts \\ []) do
    browser = opts[:browser] || browser
    %{
      javascriptEnabled: false,
      version: "",
      rotatable: false,
      takesScreenshot: true,
      cssSelectorsEnabled: true,
      nativeEvents: false,
      platform: "ANY"
    }
    |> Map.merge(Hound.Browser.make_capabilities(browser, opts))
    |> deep_merge(opts[:driver] || %{})
  end

  @doc "Get capabilities of a particular session"
  @spec session_info(String.t) :: map
  def session_info(session_id) do
    make_req(:get, "session/#{session_id}")
  end


  @doc "Destroy a session"
  @spec destroy_session(String.t) :: :ok
  def destroy_session(session_id) do
    make_req(:delete, "session/#{session_id}")
  end


  @doc "Set the timeout for a particular type of operation"
  @spec set_timeout(String.t, String.t, non_neg_integer) :: :ok
  def set_timeout(session_id, operation, time) do
    make_req(:post, "session/#{session_id}/timeouts", %{type: operation, ms: time})
  end


  @doc "Get the session log for a particular log type"
  @spec fetch_log(String.t, String.t) :: :ok
  def fetch_log(session_id, logtype) do
    make_req(:post, "session/#{session_id}/log", %{type: logtype})
  end


  @doc "Get a list of all supported log types"
  @spec fetch_log_types(String.t) :: :ok
  def fetch_log_types(session_id) do
    make_req(:get, "session/#{session_id}/log/types")
  end

  defp deep_merge(map1, map2) when is_map(map1) and is_map(map2) do
    Map.merge(map1, map2, fn _k, v1, v2 ->
      deep_merge(v1, v2)
    end)
  end

  defp deep_merge(list1, list2), do: list1 ++ list2
end
