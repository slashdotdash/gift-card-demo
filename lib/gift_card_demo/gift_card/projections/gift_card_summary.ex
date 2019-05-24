defmodule GiftCardDemo.GiftCard.Projections.GiftCardSummary do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: false}

  schema "gift_card_summary" do
    field :initial_amount, :integer, default: 0
    field :balance, :integer, default: 0

    timestamps()
  end
end
