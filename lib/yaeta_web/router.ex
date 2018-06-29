defmodule YaetaWeb.Router do
  use YaetaWeb, :router

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

  scope "/", YaetaWeb do
    pipe_through :browser # Use the default browser stack

    # get "/", PageController, :index
    resources "/app", ExpenseController
    resources "/cats", CategoryController
  end

  # Other scopes may use custom stacks.
  # scope "/api", YaetaWeb do
  #   pipe_through :api
  # end
end
