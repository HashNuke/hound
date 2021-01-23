defmodule Hound.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link(options \\ []) do
    Supervisor.start_link(__MODULE__, options, name: __MODULE__)
  end

  @impl true
  def init(options) do
    children = [
      {Hound.ConnectionServer, options},
      Hound.SessionServer
    ]

    # See https://hexdocs.pm/elixir/master/Supervisor.html#content
    # for other strategies and supported options
    Supervisor.init(children, strategy: :one_for_one)
  end
end
