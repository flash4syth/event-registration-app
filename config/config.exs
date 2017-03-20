# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :stake_retreat,
  namespace: SR,
  ecto_repos: [SR.Repo]

# Configures the endpoint
config :stake_retreat, SR.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3lAOWqKbL0r3+3t1aHWDY5QGt396FjNu7AYPZ5Z6PZWT4RjyKopD8j2Dlll3n7zk",
  render_errors: [view: SR.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SR.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure Hound for browser automation
config :hound, driver: "chrome_driver"
