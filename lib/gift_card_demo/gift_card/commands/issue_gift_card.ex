defmodule GiftCardDemo.GiftCard.Commands.IssueGiftCard do
  @enforce_keys [:id, :amount]
  defstruct [:id, :amount]
end
