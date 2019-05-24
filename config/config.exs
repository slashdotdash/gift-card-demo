use Mix.Config

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :commanded_ecto_projections,
  repo: GiftCardDemo.Repo

config :gift_card_demo,
  ecto_repos: [GiftCardDemo.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :gift_card_demo, GiftCardDemoWeb.Endpoint,
  url: [host: "localhost"],
  live_view: [
    signing_salt: "RnGHSPQFygXfHbDgURaD/dD9bU8hW8g3"
  ],
  secret_key_base: "H4y15J/wqxOISIJFRbTI3gRr1KnK+jUkabbyAz14YaLYkmAbFLimliIXTIejta75",
  render_errors: [view: GiftCardDemoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GiftCardDemo.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
