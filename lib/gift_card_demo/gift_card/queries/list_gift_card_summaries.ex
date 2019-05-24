defmodule GiftCardDemo.GiftCard.Queries.ListGiftCardSummaries do
  import Ecto.Query

  alias GiftCardDemo.GiftCard.Projections.GiftCardSummary

  def new do
    from(summary in GiftCardSummary)
  end
end
