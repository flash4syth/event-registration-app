defmodule SR.Router do
  use SR.Web, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SR do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/initialdata", JsonController, :init
  end

  scope "/", SR do
    pipe_through :api
    
    post "/post-activities", JsonController, :update_activities
    post "/post-meals", JsonController, :update_meals
  end

  # Other scopes may use custom stacks.
  # scope "/api", SR do
  #   pipe_through :api
  # end
end
