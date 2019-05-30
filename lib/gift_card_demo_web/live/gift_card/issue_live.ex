defmodule GiftCardDemoWeb.GiftCard.IssueLive do
  use Phoenix.LiveView

  alias GiftCardDemo.GiftCards
  alias GiftCardDemo.GiftCard.Commands.IssueGiftCard
  alias GiftCardDemoWeb.GiftCardView
  alias GiftCardDemoWeb.GiftCard.IssueLive
  alias GiftCardDemoWeb.Router.Helpers, as: Routes

  def mount(_session, socket) do
    {:ok, assign(socket, changeset: IssueGiftCard.changeset())}
    {:ok, assign(socket, changeset: IssueGiftCard.changeset())}
  end

  def render(assigns) do
    GiftCardView.render("new.html", assigns)
  end

  def handle_event("validate", %{"issue_gift_card" => params}, socket) do
    changeset =
      %IssueGiftCard{}
      |> IssueGiftCard.changeset(params)
      |> Map.put(:action, :dispatch)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("dispatch", %{"issue_gift_card" => params}, socket) do
    case GiftCards.issue_gift_card(params) do
      :ok ->
        socket =
          socket
          |> assign(info: "Gift card issued")
          |> assign(changeset: IssueGiftCard.changeset())

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("clear", _params, socket) do
    {:noreply, assign(socket, info: nil)}
  end
end
