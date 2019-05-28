defmodule GiftCardDemo.GiftCard.Commands.IssueGiftCard do
  use Ecto.Schema
  import Ecto.Changeset

  alias GiftCardDemo.GiftCard.Commands.IssueGiftCard

  @primary_key {:id, :binary_id, autogenerate: false}

  embedded_schema do
    field :amount, :integer
  end

  def changeset(struct \\ %IssueGiftCard{}, params \\ %{}) do
    struct
    |> cast(params, [:amount])
    |> validate_required([:amount])
  end
end
