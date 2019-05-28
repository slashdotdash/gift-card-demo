defmodule GiftCardDemo.GiftCards do
  alias GiftCardDemo.GiftCard.Router
  alias GiftCardDemo.GiftCard.Commands.{IssueGiftCard, RedeemGiftCard}
  alias GiftCardDemo.GiftCard.Queries.ListGiftCardSummaries
  alias GiftCardDemo.Repo

  def list_gift_cards do
    ListGiftCardSummaries.new() |> Repo.all()
  end

  def subscribe do
    Phoenix.PubSub.subscribe(GiftCardDemo.PubSub, "gift_cards")
  end

  def issue_gift_card(params \\ %{}),
    do: dispatch_command(IssueGiftCard, params)

  def redeem_gift_card(params \\ %{}),
    do: dispatch_command(RedeemGiftCard, params)

  defp dispatch_command(module, params) do
    struct = struct(module)
    changeset = module.changeset(struct, params)

    if changeset.valid? do
      command =
        changeset
        |> Ecto.Changeset.apply_changes()
        |> Map.put(:id, UUID.uuid4())

      Router.dispatch(command)
    else
      {:error, changeset}
    end
  end
end
