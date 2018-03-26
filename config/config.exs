# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :planner,
  ecto_repos: [Planner.Repo]

# Configures the endpoint
config :planner, PlannerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HuRHgphySa6yg8GiY3m5CUgpPU/JyHscJxXxQuqJNS1q0C1dXBmzFmX48jOtBvxo",
  render_errors: [view: PlannerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Planner.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
