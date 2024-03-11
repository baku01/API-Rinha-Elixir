defmodule ApiElixirRinha.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ApiElixirRinhaWeb.Telemetry,
      ApiElixirRinha.Repo,
      {DNSCluster, query: Application.get_env(:api_elixir_rinha, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ApiElixirRinha.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ApiElixirRinha.Finch},
      # Start a worker by calling: ApiElixirRinha.Worker.start_link(arg)
      # {ApiElixirRinha.Worker, arg},
      # Start to serve requests, typically the last entry
      ApiElixirRinhaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ApiElixirRinha.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ApiElixirRinhaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
