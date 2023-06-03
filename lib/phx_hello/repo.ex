defmodule PhxHello.Repo do
  use Ecto.Repo,
    otp_app: :phx_hello,
    adapter: Ecto.Adapters.Postgres
end
