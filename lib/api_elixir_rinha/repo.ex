defmodule ApiElixirRinha.Repo do
  use Ecto.Repo,
    otp_app: :api_elixir_rinha,
    adapter: Ecto.Adapters.Postgres
end
