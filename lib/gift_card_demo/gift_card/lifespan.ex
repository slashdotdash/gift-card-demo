defmodule GiftCardDemo.GiftCard.Lifespan do
  @behaviour Commanded.Aggregates.AggregateLifespan

  alias GiftCardDemo.GiftCard.Events.GiftCardEmptied

  def after_event(%GiftCardEmptied{}), do: :stop
  def after_event(_event), do: :timer.hours(1)

  def after_command(_command), do: :timer.hours(1)

  def after_error(_error), do: :timer.hours(1)
end
