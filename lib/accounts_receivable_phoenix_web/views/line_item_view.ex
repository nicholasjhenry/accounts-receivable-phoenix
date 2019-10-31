defmodule AccountsReceivablePhoenixWeb.LineItemView do
  use AccountsReceivablePhoenixWeb, :view

  alias AccountsReceivablePhoenix.Invoices
  alias AccountsReceivablePhoenix.Invoices.Invoice
  alias AccountsReceivablePhoenix.Invoices.LineItem
  alias AccountsReceivablePhoenix.Products
  alias AccountsReceivablePhoenix.Products.Product
  alias AccountsReceivablePhoenix.Services
  alias AccountsReceivablePhoenix.Services.Service

  def all_invoices do
    Invoices.list_invoices()
    |> Enum.map(&{&1.note, &1.id})
  end

  def all_products do
    products =
      Products.list_products()
      |> Enum.map(&{&1.name, &1.id})

    [{"None", nil}] ++ products
  end

  def all_services do
    services =
      Services.list_services()
      |> Enum.map(&{&1.name, &1.id})

    [{"None", nil}] ++ services
  end

  def invoice_link(%LineItem{invoice: %Invoice{note: note, id: id}}),
    do: link(note, to: Routes.invoice_path(AccountsReceivablePhoenixWeb.Endpoint, :show, id))

  def invoice_link(_), do: nil

  def product_link(%LineItem{product: %Product{name: name, id: id}}),
    do: link(name, to: Routes.product_path(AccountsReceivablePhoenixWeb.Endpoint, :show, id))

  def product_link(_), do: nil

  def service_link(%LineItem{service: %Service{name: name, id: id}}),
    do: link(name, to: Routes.service_path(AccountsReceivablePhoenixWeb.Endpoint, :show, id))

  def service_link(_), do: nil
end
