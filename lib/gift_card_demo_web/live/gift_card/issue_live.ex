defmodule GiftCardDemoWeb.GiftCard.IssueLive do
  use Phoenix.LiveView

  alias GiftCardDemo.GiftCards
  alias GiftCardDemoWeb.GiftCardView
  alias GiftCardDemoWeb.GiftCard.IssueLive
  alias GiftCardDemoWeb.Router.Helpers, as: Routes

  defmodule IssueGiftCardForm do
    use Ecto.Schema
    import Ecto.Changeset

    embedded_schema do
      field :amount, :integer
    end

    def new, do: changeset(%IssueGiftCardForm{id: UUID.uuid4()})

    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [:id, :amount])
      |> validate_required([:id, :amount])
    end
  end

  alias GiftCardDemoWeb.GiftCard.IssueLive.IssueGiftCardForm

  def mount(_session, socket) do
    {:ok, assign(socket, changeset: IssueGiftCardForm.new())}
  end

  def render(assigns) do
    GiftCardView.render("new.html", assigns)
  end

  def handle_event("validate", %{"issue_gift_card_form" => params}, socket) do
    changeset =
      %IssueGiftCardForm{}
      |> IssueGiftCardForm.changeset(params)
      |> Map.put(:action, :dispatch)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("dispatch", %{"issue_gift_card_form" => params}, socket) do
    case GiftCards.issue_gift_card(params) do
      :ok ->
        socket =
          socket
          |> put_flash(:info, "gift card issued")

        # |> redirect(to: Routes.live_path(socket, IssueLive))

        {:stop, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
