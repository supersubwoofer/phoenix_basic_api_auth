# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :my_app,
  ecto_repos: [MyApp.Repo]

# Configures the endpoint
config :my_app, MyAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HuRHgphySa6yg8GiY3m5CUgpPU/JyHscJxXxQuqJNS1q0C1dXBmzFmX48jOtBvxo",
  render_errors: [view: MyAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MyApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configures Ueberauth
 config :ueberauth, Ueberauth,
    base_path: "/api/auth",
    providers: [
      identity: {Ueberauth.Strategy.Identity, [
        callback_methods: ["POST"],
        callback_path: "/api/auth/identity/callback",
        nickname_field: :email,
        param_nesting: "user",
        uid_field: :email
      ]}
    ]

# Configures Guardian
config :my_app, MyApp.Accounts.Guardian,
    issuer: "MyApp",
    secret_key: "LvigLS6blw925TEt6qCSIdSwYszIYoKYK3QD/ypdjvRrUXMySyeoxfKni6554YYi",

    # We will get round to using these permissions at the end
    permissions: %{
      default: [:read_users, :write_users]
    }