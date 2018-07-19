defmodule MyAppWeb.Router do
  use MyAppWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug CORSPlug, origin: "http://localhost:5000"
    plug(:accepts, ["json"])    
  end

  pipeline :authenticated do
    plug(MyAppWeb.Plug.AuthAccessPipeline)
  end

  scope "/", MyAppWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/api", MyAppWeb do
    pipe_through(:api)

    scope "/auth" do
      post("/identity/callback", AuthenticationController, :identity_callback)
    end

    pipe_through(:authenticated)

    scope "/users" do
      resources("/current", CurrentUserController, except: [:new, :edit, :create, :delete])
      resources("/", UserController, except: [:new, :edit])
    end
  end
end
