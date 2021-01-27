defmodule AccountsReceivablePhoenixWeb.InvoiceView do
  use AccountsReceivablePhoenixWeb, :view

  alias AccountsReceivablePhoenix.Clients
  alias AccountsReceivablePhoenix.Clients.Client
  alias AccountsReceivablePhoenix.Invoices.Invoice

  def render("show.html", %{invoice: invoice} = assigns) do
    render_template(
      "show.html",
      Map.put(assigns, :line_items, group_line_items(invoice.line_items))
    )
  end

  defp group_line_items(line_items) do
    line_items =
      Enum.group_by(line_items, fn line_item ->
        if line_item.service_id != nil, do: :service, else: :product
      end)

    Map.merge(%{product: [], service: []}, line_items)
  end

  def all_clients do
    Clients.list_clients()
    |> Enum.map(&{&1.name, &1.id})
  end

  def client_link(%Invoice{client: %Client{name: name, id: id}}),
    do: link(name, to: Routes.client_path(AccountsReceivablePhoenixWeb.Endpoint, :show, id))

  def to_money(price_in_cents) do
    {dollars, cents} =
      price_in_cents
      |> Integer.to_string()
      |> String.split_at(-2)

    "$#{dollars}.#{cents}"
  end
end
