defmodule GiftCardDemo.GiftCard.Commands.RedeemGiftCard do
  @enforce_keys [:id, :amount]
  defstruct [:id, :amount]
end
