defmodule Hound do
  use Application

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  @doc false
  def start(_type, _args) do
    Hound.Supervisor.start_link
  end


  @doc false
  def driver_info do
    Hound.ConnectionServer.driver_info
  end

  @doc false
  def configs do
    Hound.ConnectionServer.configs
  end


  defdelegate start_session,      to: Hound.Helpers.Session
  defdelegate end_session,        to: Hound.Helpers.Session
  defdelegate end_session(pid),   to: Hound.Helpers.Session
  defdelegate current_session_id, to: Hound.Helpers.Session

end
