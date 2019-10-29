defmodule AccountsReceivablePhoenix.InvoicesTest do
  use AccountsReceivablePhoenix.DataCase

  alias AccountsReceivablePhoenix.Invoices

  describe "invoices" do
    alias AccountsReceivablePhoenix.Invoices.Invoice

    test "list_invoices/0 returns all invoices" do
      invoice = insert(:invoice)
      assert Invoices.list_invoices([:client]) == [invoice]
    end

    test "get_invoice!/1 returns the invoice with given id" do
      invoice = insert(:invoice)
      assert Invoices.get_invoice!(invoice.id, [:client]) == invoice
    end

    test "create_invoice/1 with valid data creates a invoice" do
      valid_attrs = %{net_days: 42, note: "some note", client_id: insert(:client).id}
      assert {:ok, %Invoice{} = invoice} = Invoices.create_invoice(valid_attrs)
      assert invoice.net_days == 42
      assert invoice.note == "some note"
    end

    test "create_invoice/1 with invalid data returns error changeset" do
      invalid_attrs = %{net_days: nil, note: nil}
      assert {:error, %Ecto.Changeset{}} = Invoices.create_invoice(invalid_attrs)
    end

    test "update_invoice/2 with valid data updates the invoice" do
      invoice = insert(:invoice)
      update_attrs = %{net_days: 43, note: "some updated note"}
      assert {:ok, %Invoice{} = invoice} = Invoices.update_invoice(invoice, update_attrs)
      assert invoice.net_days == 43
      assert invoice.note == "some updated note"
    end

    test "update_invoice/2 with invalid data returns error changeset" do
      invoice = insert(:invoice)
      invalid_attrs = %{net_days: nil, note: nil}
      assert {:error, %Ecto.Changeset{}} = Invoices.update_invoice(invoice, invalid_attrs)
      assert invoice == Invoices.get_invoice!(invoice.id, [:client])
    end

    test "delete_invoice/1 deletes the invoice" do
      invoice = insert(:invoice)
      assert {:ok, %Invoice{}} = Invoices.delete_invoice(invoice)
      assert_raise Ecto.NoResultsError, fn -> Invoices.get_invoice!(invoice.id) end
    end

    test "change_invoice/1 returns a invoice changeset" do
      invoice = insert(:invoice)
      assert %Ecto.Changeset{} = Invoices.change_invoice(invoice)
    end
  end

  describe "line_items" do
    alias AccountsReceivablePhoenix.Invoices.LineItem

    test "list_line_items/0 returns all line_items" do
      line_item = insert(:line_item)
      assert Invoices.list_line_items(invoice: [:client]) == [line_item]
    end

    test "get_line_item!/1 returns the line_item with given id" do
      line_item = insert(:line_item)
      assert Invoices.get_line_item!(line_item.id, invoice: [:client]) == line_item
    end

    test "create_line_item/1 with valid data creates a line_item" do
      valid_attrs = %{
        description: "some description",
        price_override_cents: 42,
        quantity: 42,
        invoice_id: insert(:invoice).id
      }

      assert {:ok, %LineItem{} = line_item} = Invoices.create_line_item(valid_attrs)
      assert line_item.description == "some description"
      assert line_item.price_override_cents == 42
      assert line_item.quantity == 42
    end

    test "create_line_item/1 with product creates a line_item" do
      invoice = insert(:invoice)
      product = insert(:product)

      attrs =
        params_for(:line_item)
        |> Map.merge(%{invoice_id: invoice.id, product_id: product.id})

      assert {:ok, %LineItem{} = line_item} = Invoices.create_line_item(attrs)
      assert line_item.product_id == product.id
    end

    test "create_line_item/1 with service creates a line_item" do
      invoice = insert(:invoice)
      service = insert(:service)

      attrs =
        params_for(:line_item)
        |> Map.merge(%{invoice_id: invoice.id, service_id: service.id})

      assert {:ok, %LineItem{} = line_item} = Invoices.create_line_item(attrs)
      assert line_item.service_id == service.id
    end

    test "create_line_item/1 with invalid data returns error changeset" do
      invalid_attrs = %{description: nil, price_override_cents: nil, quantity: nil}
      assert {:error, %Ecto.Changeset{}} = Invoices.create_line_item(invalid_attrs)
    end

    test "update_line_item/2 with valid data updates the line_item" do
      line_item = insert(:line_item)

      update_attrs = %{
        description: "some updated description",
        price_override_cents: 43,
        quantity: 43
      }

      assert {:ok, %LineItem{} = line_item} = Invoices.update_line_item(line_item, update_attrs)
      assert line_item.description == "some updated description"
      assert line_item.price_override_cents == 43
      assert line_item.quantity == 43
    end

    test "update_line_item/2 with invalid data returns error changeset" do
      line_item = insert(:line_item)

      invalid_attrs = %{description: nil, price_override_cents: nil, quantity: nil}
      assert {:error, %Ecto.Changeset{}} = Invoices.update_line_item(line_item, invalid_attrs)
      assert line_item == Invoices.get_line_item!(line_item.id, invoice: [:client])
    end

    test "delete_line_item/1 deletes the line_item" do
      line_item = insert(:line_item)
      assert {:ok, %LineItem{}} = Invoices.delete_line_item(line_item)
      assert_raise Ecto.NoResultsError, fn -> Invoices.get_line_item!(line_item.id) end
    end

    test "change_line_item/1 returns a line_item changeset" do
      line_item = insert(:line_item)
      assert %Ecto.Changeset{} = Invoices.change_line_item(line_item)
    end
  end
end
