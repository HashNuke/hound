defmodule Hound.Helpers.Session do
  @moduledoc "Session helpers"

  @doc """
  Switches to another session when you need more than one browser session.
  All further commands will then run in the session you switched to.
  Exits if session does not exist.
  """
  def change_session_to(session_id) do
    Hound.SessionServer.change_current_session_for_pid(self(), session_id)
  end


  @doc """
  Execute commands in a separate browser session.

      perform_in_session "another_user", fn ->
        navigate_to "http://example.com"
        click({:id, "announcement"})
      end
  """
  def perform_in_session(session_id, func) do
    previous_session_id = current_session_id()
    change_session_to(session_id)
    result = apply(func, [])
    change_session_to(previous_session_id)
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

    * `:browser` - The browser to be used (`"chrome"` | `"phantomjs"` | `"firefox"`)
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
    Hound.SessionServer.start_session_for_pid(self(), opts)
  end


  @doc """
  Ends a session that is associated with a session_id.
  """
  def end_session(session_id) do
    Hound.Session.destroy_session(session_id)
  end

  @doc """
  Ends the current session for the process
  """
  def end_session() do
    Hound.SessionServer.destroy_session_for_pid(self)
  end

  @doc false
  def current_session_id() do
    Hound.SessionServer.current_session_id(self()) ||
      raise "could not find a session for process #{inspect self()}"
  end

  @doc """
  Get list of active sessions
  """
  def active_sessions() do
    Hound.Session.active_sessions()
  end

end
