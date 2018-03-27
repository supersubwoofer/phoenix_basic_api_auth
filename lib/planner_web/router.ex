defmodule PlannerWeb.Router do
  use PlannerWeb, :router

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

  scope "/", PlannerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", PlannerWeb do
    pipe_through :api

    resources "/users", UserController, only: [:index]
    resources "/user", UserController, only: [:show]
  end
end
