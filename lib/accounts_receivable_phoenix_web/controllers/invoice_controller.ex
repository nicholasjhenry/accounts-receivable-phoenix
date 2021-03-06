defmodule AccountsReceivablePhoenixWeb.InvoiceController do
  use AccountsReceivablePhoenixWeb, :controller

  alias AccountsReceivablePhoenix.Clients
  alias AccountsReceivablePhoenix.Invoices
  alias AccountsReceivablePhoenix.Invoices.Invoice

  def index(conn, _params) do
    invoices = Invoices.list_invoices([:client])
    render(conn, "index.html", invoices: invoices)
  end

  def new(conn, _params) do
    changeset = Invoices.change_invoice(%Invoice{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"invoice" => invoice_params}) do
    case Invoices.create_invoice(invoice_params) do
      {:ok, invoice} ->
        conn
        |> put_flash(:info, "Invoice created successfully.")
        |> redirect(to: Routes.invoice_path(conn, :show, invoice))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invoice =
      Invoices.get_invoice!(id,
        product_line_items: :product,
        service_line_items: :service
      )

    client = Clients.get_client!(invoice.client_id)

    line_items =
      Invoices.list_line_items([:service, :product])
      |> Enum.filter(fn line_item -> line_item.invoice_id == invoice.id end)
      |> Enum.group_by(fn line_item ->
        if line_item.service_id != nil, do: :service, else: :product
      end)

    total =
      line_items
      |> Map.values()
      |> List.flatten()
      |> Enum.map(fn line_item ->
        price =
          line_item.price_override_cents ||
            (line_item.service && line_item.service.price_cents) ||
            (line_item.product && line_item.product.price_cents)

        IO.inspect(price, label: :price)
        price * line_item.quantity
      end)
      |> Enum.sum()

    line_items =
      %{product: [], service: []}
      |> Map.merge(line_items)

    render(conn, "show.html",
      client: client,
      invoice: invoice,
      line_items: line_items,
      total: total
    )
  end

  def edit(conn, %{"id" => id}) do
    invoice = Invoices.get_invoice!(id)
    changeset = Invoices.change_invoice(invoice)
    render(conn, "edit.html", invoice: invoice, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invoice" => invoice_params}) do
    invoice = Invoices.get_invoice!(id)

    case Invoices.update_invoice(invoice, invoice_params) do
      {:ok, invoice} ->
        conn
        |> put_flash(:info, "Invoice updated successfully.")
        |> redirect(to: Routes.invoice_path(conn, :show, invoice))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", invoice: invoice, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invoice = Invoices.get_invoice!(id)
    {:ok, _invoice} = Invoices.delete_invoice(invoice)

    conn
    |> put_flash(:info, "Invoice deleted successfully.")
    |> redirect(to: Routes.invoice_path(conn, :index))
  end
end
