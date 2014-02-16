defmodule Hound.JsonDriver.Session do
  @moduledoc "Functions to switch sessions."

  import Hound.JsonDriver.Utils

  @doc """
  When you need more than one browser session, use this function switch to another session.
  If the session doesn't exist it a new one will be created for you.
  All further commands will then run in the session you switched to.

      # Pass any name to the session to refer to it later.
      change_session_to("random-session")

  The name can be an atom or a string. The default session created is called `:default`.
  """
  def change_session_to(session_name) do
    :gen_server.call(:hound_sessions, {:change_current_session_for_pid, session_name}, 30000)
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

end