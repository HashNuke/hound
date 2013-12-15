defmodule Hound do
  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Hound.Supervisor.start_link
  end

  #TODO move all below to a genserver

  def get_status(config) do
    run_cmd("/status", config)
  end


  def create_session(config) do
    run_cmd("/session", config, :post)
  end
end
