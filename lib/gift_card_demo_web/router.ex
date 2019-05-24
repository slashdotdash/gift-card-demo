defmodule GiftCardDemoWeb.Router do
  use GiftCardDemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GiftCardDemoWeb do
    pipe_through :browser

    get "/", PageController, :index
  end
end
