defmodule GiftCardDemo.GiftCard.Events.GiftCardRedeemed do
  @derive Jason.Encoder
  defstruct [:id, :amount, :balance]
end
