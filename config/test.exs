use Mix.Config

# Configure your database
config :accounts_receivable_phoenix, AccountsReceivablePhoenix.Repo,
  username: "postgres",
  password: "postgres",
  database: "accounts_receivable_phoenix_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :accounts_receivable_phoenix, AccountsReceivablePhoenixWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
