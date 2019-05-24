defmodule GiftCardDemo.AppRouter do
  use Commanded.Commands.Router

  alias GiftCardDemo.GiftCard
  alias GiftCard.Commands.{IssueGiftCard, RedeemGiftCard}

  identify(GiftCardDemo.GiftCard, by: :id)
  dispatch([IssueGiftCard, RedeemGiftCard], to: GiftCard, lifespan: GiftCard.Lifespan)
end
