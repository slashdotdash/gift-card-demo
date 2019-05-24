defmodule GiftCardDemo.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      GiftCardDemo.Repo,
      GiftCardDemo.GiftCard.Supervisor,
      GiftCardDemoWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: GiftCardDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    GiftCardDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
