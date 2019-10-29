defmodule AccountsReceivablePhoenix.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: AccountsReceivablePhoenix.Repo

  alias AccountsReceivablePhoenix.Clients.Client
  alias AccountsReceivablePhoenix.Invoices.Invoice
  alias AccountsReceivablePhoenix.Invoices.LineItem
  alias AccountsReceivablePhoenix.Products.Product
  alias AccountsReceivablePhoenix.Services.Service

  def client_factory do
    %Client{
      email: Faker.Internet.email(),
      name: Faker.Company.name()
    }
  end

  def product_factory do
    %Product{
      name: Faker.Commerce.product_name(),
      price_cents: Faker.random_between(99, 1099)
    }
  end

  def service_factory do
    %Service{
      name: Faker.Commerce.product_name(),
      price_cents: Faker.random_between(99, 1099)
    }
  end

  @spec invoice_factory :: AccountsReceivablePhoenix.Invoices.Invoice.t()
  def invoice_factory do
    %Invoice{
      net_days: Faker.random_between(1, 31),
      note: Faker.Lorem.sentence(),
      client: build(:client)
    }
  end

  def line_item_factory do
    %LineItem{
      description: Faker.Lorem.sentence(),
      quantity: Faker.random_between(1, 10),
      invoice: build(:invoice)
    }
  end
end
