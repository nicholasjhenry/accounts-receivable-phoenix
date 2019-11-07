defmodule AccountsReceivablePhoenixWeb.InvoiceViewtest do
  use AccountsReceivablePhoenix.DataCase
  import AccountsReceivablePhoenixWeb.InvoiceView
  import Phoenix.HTML, only: [safe_to_string: 1]
  alias AccountsReceivablePhoenix.Clients.Client

  describe "all_clients/0" do
    test "lists clients as tuple for options" do
      [%Client{id: id_1, name: name_1}, %Client{id: id_2, name: name_2}] = insert_list(2, :client)

      assert [{name_1, id_1}, {name_2, id_2}] == all_clients()
    end
  end

  describe "client_link/1" do
    test "creates link to invoices client" do
      %Client{name: client_name, id: client_id} = client = insert(:client)
      invoice = insert(:invoice, client: client)

      assert "<a href=\"/clients/#{client_id}\">#{client_name}</a>" ==
               invoice |> client_link |> safe_to_string()
    end
  end

  describe "to_money/1" do
    test "converts cents to money string" do
      assert "$50.25" == to_money(5025)
    end
  end
end
