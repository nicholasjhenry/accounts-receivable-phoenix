defmodule AccountsReceivablePhoenix.InvoicesTest do
  use AccountsReceivablePhoenix.DataCase

  alias AccountsReceivablePhoenix.Invoices

  describe "invoices" do
    alias AccountsReceivablePhoenix.Invoices.Invoice

    @valid_attrs %{net_days: 42, note: "some note"}
    @update_attrs %{net_days: 43, note: "some updated note"}
    @invalid_attrs %{net_days: nil, note: nil}

    def invoice_fixture(attrs \\ %{}) do
      {:ok, invoice} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Invoices.create_invoice()

      invoice
    end

    test "list_invoices/0 returns all invoices" do
      invoice = invoice_fixture()
      assert Invoices.list_invoices() == [invoice]
    end

    test "get_invoice!/1 returns the invoice with given id" do
      invoice = invoice_fixture()
      assert Invoices.get_invoice!(invoice.id) == invoice
    end

    test "create_invoice/1 with valid data creates a invoice" do
      assert {:ok, %Invoice{} = invoice} = Invoices.create_invoice(@valid_attrs)
      assert invoice.net_days == 42
      assert invoice.note == "some note"
    end

    test "create_invoice/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Invoices.create_invoice(@invalid_attrs)
    end

    test "update_invoice/2 with valid data updates the invoice" do
      invoice = invoice_fixture()
      assert {:ok, %Invoice{} = invoice} = Invoices.update_invoice(invoice, @update_attrs)
      assert invoice.net_days == 43
      assert invoice.note == "some updated note"
    end

    test "update_invoice/2 with invalid data returns error changeset" do
      invoice = invoice_fixture()
      assert {:error, %Ecto.Changeset{}} = Invoices.update_invoice(invoice, @invalid_attrs)
      assert invoice == Invoices.get_invoice!(invoice.id)
    end

    test "delete_invoice/1 deletes the invoice" do
      invoice = invoice_fixture()
      assert {:ok, %Invoice{}} = Invoices.delete_invoice(invoice)
      assert_raise Ecto.NoResultsError, fn -> Invoices.get_invoice!(invoice.id) end
    end

    test "change_invoice/1 returns a invoice changeset" do
      invoice = invoice_fixture()
      assert %Ecto.Changeset{} = Invoices.change_invoice(invoice)
    end
  end

  describe "line_items" do
    alias AccountsReceivablePhoenix.Invoices.LineItem

    @valid_attrs %{description: "some description", price_override_cents: 42, quantity: 42}
    @update_attrs %{description: "some updated description", price_override_cents: 43, quantity: 43}
    @invalid_attrs %{description: nil, price_override_cents: nil, quantity: nil}

    def line_item_fixture(attrs \\ %{}) do
      {:ok, line_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Invoices.create_line_item()

      line_item
    end

    test "list_line_items/0 returns all line_items" do
      line_item = line_item_fixture()
      assert Invoices.list_line_items() == [line_item]
    end

    test "get_line_item!/1 returns the line_item with given id" do
      line_item = line_item_fixture()
      assert Invoices.get_line_item!(line_item.id) == line_item
    end

    test "create_line_item/1 with valid data creates a line_item" do
      assert {:ok, %LineItem{} = line_item} = Invoices.create_line_item(@valid_attrs)
      assert line_item.description == "some description"
      assert line_item.price_override_cents == 42
      assert line_item.quantity == 42
    end

    test "create_line_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Invoices.create_line_item(@invalid_attrs)
    end

    test "update_line_item/2 with valid data updates the line_item" do
      line_item = line_item_fixture()
      assert {:ok, %LineItem{} = line_item} = Invoices.update_line_item(line_item, @update_attrs)
      assert line_item.description == "some updated description"
      assert line_item.price_override_cents == 43
      assert line_item.quantity == 43
    end

    test "update_line_item/2 with invalid data returns error changeset" do
      line_item = line_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Invoices.update_line_item(line_item, @invalid_attrs)
      assert line_item == Invoices.get_line_item!(line_item.id)
    end

    test "delete_line_item/1 deletes the line_item" do
      line_item = line_item_fixture()
      assert {:ok, %LineItem{}} = Invoices.delete_line_item(line_item)
      assert_raise Ecto.NoResultsError, fn -> Invoices.get_line_item!(line_item.id) end
    end

    test "change_line_item/1 returns a line_item changeset" do
      line_item = line_item_fixture()
      assert %Ecto.Changeset{} = Invoices.change_line_item(line_item)
    end
  end
end
