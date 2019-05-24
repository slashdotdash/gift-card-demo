defmodule GiftCardDemoWeb.PageController do
  use GiftCardDemoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
