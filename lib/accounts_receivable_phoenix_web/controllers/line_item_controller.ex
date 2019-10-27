defmodule AccountsReceivablePhoenixWeb.LineItemController do
  use AccountsReceivablePhoenixWeb, :controller

  alias AccountsReceivablePhoenix.Invoices
  alias AccountsReceivablePhoenix.Invoices.LineItem

  def index(conn, _params) do
    line_items = Invoices.list_line_items()
    render(conn, "index.html", line_items: line_items)
  end

  def new(conn, _params) do
    changeset = Invoices.change_line_item(%LineItem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"line_item" => line_item_params}) do
    case Invoices.create_line_item(line_item_params) do
      {:ok, line_item} ->
        conn
        |> put_flash(:info, "Line item created successfully.")
        |> redirect(to: Routes.line_item_path(conn, :show, line_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    line_item = Invoices.get_line_item!(id)
    render(conn, "show.html", line_item: line_item)
  end

  def edit(conn, %{"id" => id}) do
    line_item = Invoices.get_line_item!(id)
    changeset = Invoices.change_line_item(line_item)
    render(conn, "edit.html", line_item: line_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "line_item" => line_item_params}) do
    line_item = Invoices.get_line_item!(id)

    case Invoices.update_line_item(line_item, line_item_params) do
      {:ok, line_item} ->
        conn
        |> put_flash(:info, "Line item updated successfully.")
        |> redirect(to: Routes.line_item_path(conn, :show, line_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", line_item: line_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    line_item = Invoices.get_line_item!(id)
    {:ok, _line_item} = Invoices.delete_line_item(line_item)

    conn
    |> put_flash(:info, "Line item deleted successfully.")
    |> redirect(to: Routes.line_item_path(conn, :index))
  end
end
