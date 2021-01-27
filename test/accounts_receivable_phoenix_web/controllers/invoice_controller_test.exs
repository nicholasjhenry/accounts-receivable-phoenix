defmodule AccountsReceivablePhoenixWeb.InvoiceControllerTest do
  use AccountsReceivablePhoenixWeb.ConnCase

  describe "index" do
    test "lists all invoices", %{conn: conn} do
      conn = get(conn, Routes.invoice_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Invoices"
    end
  end

  describe "show" do
    setup :create_invoice

    test "shows an invoice", %{conn: conn, invoice: invoice} do
      conn = get(conn, Routes.invoice_path(conn, :show, invoice))

      html_response(conn, 200)
      |> assert_html("h1", "Show Invoice")
    end
  end

  describe "new invoice" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.invoice_path(conn, :new))
      assert html_response(conn, 200) =~ "New Invoice"
    end
  end

  describe "create invoice" do
    test "redirects to show when data is valid", %{conn: conn} do
      create_attrs = %{net_days: 42, note: "some note", client_id: insert(:client).id}
      conn = post(conn, Routes.invoice_path(conn, :create), invoice: create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.invoice_path(conn, :show, id)

      conn = get(conn, Routes.invoice_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Invoice"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      invalid_attrs = %{net_days: nil, note: nil}
      conn = post(conn, Routes.invoice_path(conn, :create), invoice: invalid_attrs)
      assert html_response(conn, 200) =~ "New Invoice"
    end
  end

  describe "edit invoice" do
    setup [:create_invoice]

    test "renders form for editing chosen invoice", %{conn: conn, invoice: invoice} do
      conn = get(conn, Routes.invoice_path(conn, :edit, invoice))
      assert html_response(conn, 200) =~ "Edit Invoice"
    end
  end

  describe "update invoice" do
    setup [:create_invoice]

    test "redirects when data is valid", %{conn: conn, invoice: invoice} do
      update_attrs = %{net_days: 43, note: "some updated note"}
      conn = put(conn, Routes.invoice_path(conn, :update, invoice), invoice: update_attrs)
      assert redirected_to(conn) == Routes.invoice_path(conn, :show, invoice)

      conn = get(conn, Routes.invoice_path(conn, :show, invoice))
      assert html_response(conn, 200) =~ "some updated note"
    end

    test "renders errors when data is invalid", %{conn: conn, invoice: invoice} do
      invalid_attrs = %{net_days: nil, note: nil}
      conn = put(conn, Routes.invoice_path(conn, :update, invoice), invoice: invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Invoice"
    end
  end

  describe "delete invoice" do
    setup [:create_invoice]

    test "deletes chosen invoice", %{conn: conn, invoice: invoice} do
      conn = delete(conn, Routes.invoice_path(conn, :delete, invoice))
      assert redirected_to(conn) == Routes.invoice_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.invoice_path(conn, :show, invoice))
      end
    end
  end

  defp create_invoice(_) do
    {:ok, invoice: insert(:invoice)}
  end
end
