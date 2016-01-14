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
  def change_session_to(session_name, additional_capabilities \\ %{}) do
    Hound.SessionServer.change_current_session_for_pid(self, session_name, additional_capabilities)
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
  Execute commands in a seperate browser session.

      in_browser_session "another_user" do
        navigate_to "http://example.com"
        click({:id, "announcement"})
      end
  """
  def in_browser_session(session_name, func) do
    change_session_to(session_name)
    apply(func, [])
    change_to_default_session()
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
  """
  def start_session(additional_capabilities \\ %{}) do
    Hound.SessionServer.session_for_pid(self, additional_capabilities)
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
    Hound.SessionServer.current_session_id(self) ||
      raise "could not find a session for process #{inspect self}"
  end

end
