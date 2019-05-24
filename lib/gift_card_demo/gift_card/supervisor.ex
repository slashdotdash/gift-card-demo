defmodule GiftCardDemo.GiftCard.Supervisor do
  @moduledoc false

  use Supervisor

  alias GiftCardDemo.GiftCard.Projections.GiftCardSummaryProjector

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl Supervisor
  def init(_arg) do
    Supervisor.init(
      [
        {Registry,
         keys: :duplicate, name: Registry.GiftCardSummary, partitions: System.schedulers_online()},
        GiftCardSummaryProjector
      ],
      strategy: :one_for_one
    )
  end
end
