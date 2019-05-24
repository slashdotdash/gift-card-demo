defmodule GiftCardDemo.GiftCards do
  alias GiftCardDemo.AppRouter
  alias GiftCardDemo.GiftCard.Commands.{IssueGiftCard, RedeemGiftCard}
  alias GiftCardDemo.GiftCard.Queries.ListGiftCardSummaries
  alias GiftCardDemo.Repo

  def list_gift_cards do
    ListGiftCardSummaries.new() |> Repo.all()
  end

  def subscribe do
    with {:ok, _} <- Registry.register(Registry.GiftCardSummary, :gift_card_summary, []) do
      :ok
    end
  end

  def issue_gift_card(amount) do
    command = %IssueGiftCard{id: UUID.uuid4(), amount: amount}

    AppRouter.dispatch(command)
  end

  def redeem_gift_card(id, amount) do
    command = %RedeemGiftCard{id: id, amount: amount}

    AppRouter.dispatch(command)
  end
end
