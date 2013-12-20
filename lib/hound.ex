defmodule Hound do
  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, options) do
    Hound.Supervisor.start_link(options)
  end


  def start(options // []) do
    :application.start :hound, options
  end


  def get_driver_info do
    :gen_server.call(:hound_connection, :driver_info)
  end


  def start_session do
    :gen_server.call(:hound_sessions, :get_session_for_pid, 60000)
  end


  def change_session_to(session_name) do
    :gen_server.call(:hound_sessions, {:change_current_session_for_pid, session_name}, 30000)
  end


  def change_to_default_session do
    change_session_to(:default)
  end


  def get_current_session_id do
    :gen_server.call(:hound_sessions, :get_session_for_pid, 30000)
  end


  def end_session() do
    :gen_server.call(:hound_sessions, :destroy_sessions_for_pid, 30000)
  end
end
