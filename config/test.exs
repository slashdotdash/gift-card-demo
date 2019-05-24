use Mix.Config

config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  database: "giftcard_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :gift_card_demo, GiftCardDemo.Repo,
  database: "giftcard_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  migration_source: "ecto_migrations"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gift_card_demo, GiftCardDemoWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
