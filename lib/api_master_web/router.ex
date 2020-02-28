defmodule ApiMasterWeb.Router do
  use ApiMasterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ApiMasterWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", ApiMasterWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    resources "/clients", ClientController, except: [:new, :edit]
  end
end
