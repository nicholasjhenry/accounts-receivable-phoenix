defmodule AccountsReceivablePhoenix.Repo do
  use Ecto.Repo,
    otp_app: :accounts_receivable_phoenix,
    adapter: Ecto.Adapters.Postgres
end
