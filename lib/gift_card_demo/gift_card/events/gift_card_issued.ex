defmodule GiftCardDemo.GiftCard.Events.GiftCardIssued do
  @derive Jason.Encoder
  defstruct [:id, :amount, :balance]
end
