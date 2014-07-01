defmodule Hound.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link(options \\ []) do
    :supervisor.start_link(__MODULE__, [options])
  end


  def init([options]) do
    children = [
      worker(Hound.ConnectionServer, [options]),
      worker(Hound.SessionServer, [])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
