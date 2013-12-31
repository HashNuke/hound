defmodule Hound do
  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  @doc false
  def start(_type, options) do
    start(options)
  end

  @doc """
  Starts the Hound server.

      # Start Hound for localhost webdriver server (Selenium assumed at port 4444)
      Hound.start

      # Start Hound for remote webdriver server at port 5555
      Hound.start [host: "http://example.com", port: 5555]
  """
  def start(options // []) do
    Hound.Supervisor.start_link(options)
  end


  @doc false
  def get_driver_info do
    :gen_server.call(:hound_connection, :driver_info)
  end


  @doc """
  Starts a Hound session.

  Use this in your test case's setup block to start a Hound session for each test case.

      defmodule HoundTest do
        use ExUnit.Case
        use Hound.Helpers

        setup do
          Hound.start_session
          :ok
        end

        teardown do
          :ok = Hound.end_session
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
  def start_session do
    :gen_server.call(:hound_sessions, :get_session_for_pid, 60000)
  end


  @doc """
  Ends a Hound session. If you have multiple sessions, all of those sessions are killed.

  For an example, take a look at the documentation for `start_session`.
  """
  def end_session() do
    :gen_server.call(:hound_sessions, :destroy_sessions_for_pid, 30000)
  end


  @doc """
  When you need more than one browser session, use this function switch to another session.
  If the session doesn't exist it a new one will be created for you.
  All further commands will then run in the session you switched to.

      # Pass any name to the session to refer to it later.
      Hound.change_session_to("random-session")

  The name can be an atom or a string. The default session created is called `:default`.
  """
  def change_session_to(session_name) do
    :gen_server.call(:hound_sessions, {:change_current_session_for_pid, session_name}, 30000)
  end


  @doc """
  When running multiple browser sessions, calling this function will switch to the default browser session.

      Hound.change_to_default_session

      # is the same as calling
      Hound.change_session_to(:default)
  """
  def change_to_default_session do
    change_session_to(:default)
  end


  @doc false
  def get_current_session_id do
    :gen_server.call(:hound_sessions, :get_session_for_pid, 30000)
  end
end
