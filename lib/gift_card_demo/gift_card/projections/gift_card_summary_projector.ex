defmodule GiftCardDemo.GiftCard.Projections.GiftCardSummaryProjector do
  use Commanded.Projections.Ecto, name: "GiftCardSummaryProjector"

  alias GiftCardDemo.GiftCard.Events.{GiftCardIssued, GiftCardRedeemed}
  alias GiftCardDemo.GiftCard.Projections.GiftCardSummary

  project %GiftCardIssued{} = event, fn multi ->
    %GiftCardIssued{id: id, amount: amount, balance: balance} = event

    summary = %GiftCardSummary{id: id, initial_amount: amount, balance: balance}

    Ecto.Multi.insert(multi, :gift_card_summary, summary)
  end

  project %GiftCardRedeemed{} = event, fn multi ->
    %GiftCardRedeemed{id: id, balance: balance} = event

    Ecto.Multi.update_all(multi, :gift_card_summary, gift_card_query(id),
      set: [
        balance: balance
      ]
    )
  end

  @doc """
  Publish changes after update.
  """
  def after_update(_event, _metadata, changes) do
    Phoenix.PubSub.broadcast(GiftCardDemo.PubSub, "gift_cards", changes)
  end

  defp gift_card_query(id) do
    from(summary in GiftCardSummary, where: summary.id == ^id)
  end
end
