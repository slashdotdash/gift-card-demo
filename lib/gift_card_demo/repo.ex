defmodule GiftCardDemo.Repo do
  use Ecto.Repo,
    otp_app: :gift_card_demo,
    adapter: Ecto.Adapters.Postgres
end
