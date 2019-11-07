# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AccountsReceivablePhoenix.Repo.insert!(%AccountsReceivablePhoenix.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias AccountsReceivablePhoenix.Clients.Client
alias AccountsReceivablePhoenix.Invoices.Invoice
alias AccountsReceivablePhoenix.Invoices.LineItem
alias AccountsReceivablePhoenix.Products.Product
alias AccountsReceivablePhoenix.Repo
alias AccountsReceivablePhoenix.Services.Service

antivirus_software =
  Repo.insert!(%Product{
    name: "Anti-virus Software",
    price_cents: 20000
  })

serverless_servers =
  Repo.insert!(%Product{
    name: "Serverless Servers",
    price_cents: 100_000
  })

programming =
  Repo.insert!(%Service{
    name: "Programming",
    price_cents: 8000
  })

refactoring =
  Repo.insert!(%Service{
    name: "Refactoring",
    price_cents: 35000
  })

acme =
  Repo.insert!(%Client{
    email: "ap@acme.com",
    name: "Acme, Inc."
  })

build =
  Repo.insert!(%Invoice{
    client_id: acme.id,
    net_days: 30,
    note: "Invoice for writing software for Acme"
  })

refactor =
  Repo.insert!(%Invoice{
    client_id: acme.id,
    net_days: 30,
    note: "Invoice for refactoring software for Acme"
  })

_build_programmer_1 =
  Repo.insert!(%LineItem{
    invoice_id: build.id,
    service_id: programming.id,
    quantity: 40,
    price_override_cents: 16000,
    description: "Super awesome 10x dev"
  })

_build_programmer_2 =
  Repo.insert!(%LineItem{
    invoice_id: build.id,
    service_id: programming.id,
    quantity: 40,
    description: "Normal person working at a sustainable pace"
  })

_build_servers =
  Repo.insert!(%LineItem{
    invoice_id: build.id,
    product_id: serverless_servers.id,
    quantity: 20,
    description: "Enough serverless hardware to achieve web-scale"
  })

_refactor_consultant =
  Repo.insert!(%LineItem{
    invoice_id: refactor.id,
    service_id: refactoring.id,
    quantity: 40,
    description: "Fixing 10x dev's mistakes"
  })

_refactor_antivirus =
  Repo.insert!(%LineItem{
    invoice_id: refactor.id,
    product_id: antivirus_software.id,
    quantity: 1,
    description: "Anti-virus software subscription"
  })
