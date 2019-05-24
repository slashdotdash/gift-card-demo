defmodule GiftCardDemo.GiftCard do
  @moduledoc """
  A gift card is a prepaid stored-value money card, usually issued by a retailer
  or bank, to be used as an alternative to cash for purchases within a
  particular store or related businesses.

  A card is issued with an amount and can be redeemed many times until the
  amount is zero, and it is empty.
  """

  alias GiftCardDemo.GiftCard
  alias GiftCardDemo.GiftCard.Commands.{IssueGiftCard, RedeemGiftCard}
  alias GiftCardDemo.GiftCard.Events.{GiftCardEmptied, GiftCardIssued, GiftCardRedeemed}

  defstruct [:id, :balance]

  def execute(%GiftCard{id: nil}, %IssueGiftCard{} = command) do
    %IssueGiftCard{id: id, amount: amount} = command

    if is_number(amount) and amount > 0 do
      %GiftCardIssued{id: id, amount: amount, balance: amount}
    else
      {:erorr, {:invalid_amount, amount}}
    end
  end

  def execute(%GiftCard{}, %IssueGiftCard{}), do: {:error, :gift_card_exists}

  def execute(%GiftCard{id: nil}, %RedeemGiftCard{}), do: {:error, :invalid_gift_card}

  def execute(%GiftCard{} = gift_card, %RedeemGiftCard{} = command) do
    %GiftCard{balance: balance} = gift_card
    %RedeemGiftCard{id: id, amount: amount} = command

    if is_number(amount) and amount > 0 do
      balance = balance - amount

      cond do
        balance < 0 ->
          {:error, :insufficient_balance}

        balance > 0 ->
          %GiftCardRedeemed{id: id, amount: amount, balance: balance}

        balance == 0 ->
          [
            %GiftCardRedeemed{id: id, amount: amount, balance: 0},
            %GiftCardEmptied{id: id}
          ]
      end
    else
      {:erorr, {:invalid_amount, amount}}
    end
  end

  def apply(%GiftCard{}, %GiftCardIssued{} = event) do
    %GiftCardIssued{id: id, balance: balance} = event

    %GiftCard{id: id, balance: balance}
  end

  def apply(%GiftCard{} = gift_card, %GiftCardRedeemed{} = event) do
    %GiftCardRedeemed{balance: balance} = event

    %GiftCard{gift_card | balance: balance}
  end

  def apply(%GiftCard{} = gift_card, %GiftCardEmptied{}), do: gift_card
end
