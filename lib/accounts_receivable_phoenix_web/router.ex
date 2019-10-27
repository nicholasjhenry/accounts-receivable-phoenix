defmodule AccountsReceivablePhoenixWeb.Router do
  use AccountsReceivablePhoenixWeb, :router

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

  scope "/", AccountsReceivablePhoenixWeb do
    pipe_through :browser

    get "/", InvoiceController, :index
    resources("/clients", ClientController)
    resources("/invoices", InvoiceController)
    resources("/line_items", LineItemController)
    resources("/products", ProductController)
    resources("/services", ServiceController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", AccountsReceivablePhoenixWeb do
  #   pipe_through :api
  # end
end
