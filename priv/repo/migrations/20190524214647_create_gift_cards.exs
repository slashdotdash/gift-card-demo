defmodule GiftCardDemo.Repo.Migrations.CreateGiftCards do
  use Ecto.Migration

  def change do
    create table(:gift_card_summary) do
      add(:initial_amount, :integer, nil: false)
      add(:balance, :integer, nil: false)

      timestamps()
    end
  end
end
