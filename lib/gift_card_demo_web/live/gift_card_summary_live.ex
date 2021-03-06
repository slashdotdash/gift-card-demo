defmodule GiftCardDemoWeb.GiftCardSummaryLive do
  use Phoenix.LiveView

  alias GiftCardDemo.GiftCards
  alias GiftCardDemo.GiftCard.Projections.GiftCardSummary
  alias GiftCardDemoWeb.GiftCardSummaryView

  def mount(_session, socket) do
    if connected?(socket), do: GiftCards.subscribe()

    {:ok, fetch(socket)}
  end

  def render(assigns) do
    GiftCardSummaryView.render("index.html", assigns)
  end

  def handle_info({:gift_card_summary, %GiftCardSummary{}}, socket) do
    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    assign(socket, gift_cards: GiftCards.list_gift_cards())
  end
end
