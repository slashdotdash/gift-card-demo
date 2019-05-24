defmodule GiftCardDemo.GiftCard.Projections.GiftCardSummaryProjector do
  use Commanded.Projections.Ecto, name: __MODULE__

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
  Publish gift card summary after update.
  """
  def after_update(_event, _metadata, %{gift_card_summary: gift_card_summary}) do
    Registry.dispatch(Registry.GiftCardSummary, :gift_card_summary, fn entries ->
      for {pid, _} <- entries, do: send(pid, {:gift_card_summary, gift_card_summary})
    end)
  end

  def after_update(_event, _metadata, _changes), do: :ok

  defp gift_card_query(id) do
    from(summary in GiftCardSummary, where: summary.id == ^id)
  end
end
