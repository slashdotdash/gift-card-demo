defmodule GiftCardDemo.GiftCard.Projections.GiftCardSummary do
  use Ecto.Schema

  schema "gift_card_summary" do
    field :initial_amount, :integer, default: 0
    field :balance, :integer, default: 0
  end
end
