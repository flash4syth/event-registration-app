use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :stake_retreat, SR.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :stake_retreat, SR.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: Application.get_env(:stake_retreat, :db_user),
  password: Application.get_env(:stake_retreat, :db_pass),
  database: Application.get_env(:stake_retreat, :db_name),
  hostname: Application.get_env(:stake_retreat, :db_host),
  pool: Ecto.Adapters.SQL.Sandbox
