defmodule Hound.Helpers.Session do
  @moduledoc "Session helpers"

  @doc """
  Switches to another session.

  When you need more than one browser session, use this function switch to another session.
  If the session doesn't exist it a new one will be created for you.
  All further commands will then run in the session you switched to.

      # Pass any name to the session to refer to it later.
      change_session_to("random-session")

  The name can be an atom or a string. The default session created is called `:default`.
  """
  def change_session_to(session_name, opts \\ []) do
    Hound.SessionServer.change_current_session_for_pid(self(), session_name, opts)
  end


  @doc """
  When running multiple browser sessions, calling this function will switch to the default browser session.

      change_to_default_session

      # is the same as calling
      change_session_to(:default)
  """
  def change_to_default_session do
    change_session_to(:default)
  end


  @doc """
  Execute commands in a separate browser session.

      in_browser_session "another_user", fn ->
        navigate_to "http://example.com"
        click({:id, "announcement"})
      end
  """
  def in_browser_session(session_name, func) do
    previous_session_name = current_session_name()
    change_session_to(session_name)
    result = apply(func, [])
    change_session_to(previous_session_name)
    result 
  end


  @doc """
  Starts a Hound session.

  Use this in your test case's setup block to start a Hound
  session for each test case. The session will be terminated
  when the caller process exits or when `end_session/0` is
  explicitly called.

      defmodule HoundTest do
        use ExUnit.Case
        use Hound.Helpers

        setup do
          Hound.start_session
          :ok
        end

        test "the truth", meta do
          navigate_to("http://example.com/guestbook.html")

          find_element(:name, "message")
          |> fill_field("Happy Birthday ~!")
          |> submit_element()

          assert page_title() == "Thank you"
        end

      end

  ## Options

  The following options can be passed to `start_session`:

    * `:browser` - The browser to be used (`"chrome"` | `"chrome_headless"` | `"phantomjs"` | `"firefox"`)
    * `:user_agent` - The user agent string that will be used for the requests.
      The following atoms can also be passed
        * `:firefox_desktop` (aliased to `:firefox`)
        * `:chrome_desktop` (aliased to `:chrome`)
        * `:phantomjs`
        * `:chrome_android_sp` (aliased to `:android`)
        * `:safari_iphone` (aliased to `:iphone`)
    * `:metadata` - The metadata to be included in the requests.
      See `Hound.Metadata` for more information
    * `:driver` - The additional capabilities to be passed directly to the webdriver.
  """
  def start_session(opts \\ []) do
    Hound.SessionServer.session_for_pid(self(), opts)
  end


  @doc """
  Ends a Hound session that is associated with a pid.

  If you have multiple sessions, all of those sessions are killed.
  """
  def end_session(pid \\ self()) do
    Hound.SessionServer.destroy_sessions_for_pid(pid)
  end


  @doc false
  def current_session_id do
    Hound.SessionServer.current_session_id(self()) ||
      raise "could not find a session for process #{inspect self()}"
  end


  @doc false
  def current_session_name do
      Hound.SessionServer.current_session_name(self()) ||
        raise "could not find a session for process #{inspect self()}"


  end
end
