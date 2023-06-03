defmodule PhxHello.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhxHelloWeb.Telemetry,
      # Start the Ecto repository
      PhxHello.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhxHello.PubSub},
      # Start Finch
      {Finch, name: PhxHello.Finch},
      # Start the Endpoint (http/https)
      PhxHelloWeb.Endpoint
      # Start a worker by calling: PhxHello.Worker.start_link(arg)
      # {PhxHello.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxHello.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxHelloWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
