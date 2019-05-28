defmodule GiftCardDemo.GiftCard.Commands.RedeemGiftCard do
  use Ecto.Schema
  import Ecto.Changeset

  alias GiftCardDemo.GiftCard.Commands.RedeemGiftCard

  @primary_key {:id, :binary_id, autogenerate: false}

  embedded_schema do
    field :amount, :integer
  end

  def changeset(struct \\ %RedeemGiftCard{}, params \\ %{}) do
    struct
    |> cast(params, [:amount])
    |> validate_required([:amount])
  end
end
