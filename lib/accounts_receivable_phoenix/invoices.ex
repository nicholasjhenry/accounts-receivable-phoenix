defmodule AccountsReceivablePhoenix.Invoices do
  @moduledoc """
  The Invoices context.
  """

  import Ecto.Query, warn: false
  alias AccountsReceivablePhoenix.Repo

  alias AccountsReceivablePhoenix.Invoices.{Invoice, LineItem}

  @doc """
  Returns the list of invoices.

  ## Examples

      iex> list_invoices()
      [%Invoice{}, ...]

  """
  def list_invoices(preload \\ []) do
    Invoice
    |> preload(^preload)
    |> Repo.all()
  end

  @doc """
  Gets a single invoice.

  Raises `Ecto.NoResultsError` if the Invoice does not exist.

  ## Examples

      iex> get_invoice!(123)
      %Invoice{}

      iex> get_invoice!(456)
      ** (Ecto.NoResultsError)

  """
  def get_invoice!(id, preload \\ []) do
    Invoice
    |> preload(^preload)
    |> Repo.get!(id)
  end

  def get_calculated_invoice!(id) do
    query =
      from invoice in Invoice,
        left_join: pli in assoc(invoice, :product_line_items),
        join: p in assoc(pli, :product),
        left_join: sli in assoc(invoice, :service_line_items),
        join: s in assoc(sli, :service),
        preload: [product_line_items: {pli, product: p}, service_line_items: {sli, service: s}]

    invoice = Repo.get!(query, id)

    line_items =
      (invoice.service_line_items ++ invoice.product_line_items)
      |> Enum.map(&LineItem.calculate/1)
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
            (line_item.service_id && line_item.service.price_cents) ||
            (line_item.product_id && line_item.product.price_cents)

        price * line_item.quantity
      end)
      |> Enum.sum()

    line_items =
      %{product: [], service: []}
      |> Map.merge(line_items)

    %{invoice: invoice, line_items: line_items, total: total}
  end

  @doc """
  Creates a invoice.

  ## Examples

      iex> create_invoice(%{field: value})
      {:ok, %Invoice{}}

      iex> create_invoice(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_invoice(attrs \\ %{}) do
    %Invoice{}
    |> Invoice.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a invoice.

  ## Examples

      iex> update_invoice(invoice, %{field: new_value})
      {:ok, %Invoice{}}

      iex> update_invoice(invoice, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_invoice(%Invoice{} = invoice, attrs) do
    invoice
    |> Invoice.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Invoice.

  ## Examples

      iex> delete_invoice(invoice)
      {:ok, %Invoice{}}

      iex> delete_invoice(invoice)
      {:error, %Ecto.Changeset{}}

  """
  def delete_invoice(%Invoice{} = invoice) do
    Repo.delete(invoice)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking invoice changes.

  ## Examples

      iex> change_invoice(invoice)
      %Ecto.Changeset{source: %Invoice{}}

  """
  def change_invoice(%Invoice{} = invoice) do
    Invoice.changeset(invoice, %{})
  end

  alias AccountsReceivablePhoenix.Invoices.LineItem

  @doc """
  Returns the list of line_items.

  ## Examples

      iex> list_line_items()
      [%LineItem{}, ...]

  """
  def list_line_items(preload \\ []) do
    LineItem
    |> preload(^preload)
    |> Repo.all()
  end

  @doc """
  Gets a single line_item.

  Raises `Ecto.NoResultsError` if the Line item does not exist.

  ## Examples

      iex> get_line_item!(123)
      %LineItem{}

      iex> get_line_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_line_item!(id, preload \\ []) do
    LineItem
    |> preload(^preload)
    |> Repo.get!(id)
  end

  @doc """
  Creates a line_item.

  ## Examples

      iex> create_line_item(%{field: value})
      {:ok, %LineItem{}}

      iex> create_line_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_line_item(attrs \\ %{}) do
    %LineItem{}
    |> LineItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a line_item.

  ## Examples

      iex> update_line_item(line_item, %{field: new_value})
      {:ok, %LineItem{}}

      iex> update_line_item(line_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_line_item(%LineItem{} = line_item, attrs) do
    line_item
    |> LineItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a LineItem.

  ## Examples

      iex> delete_line_item(line_item)
      {:ok, %LineItem{}}

      iex> delete_line_item(line_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_line_item(%LineItem{} = line_item) do
    Repo.delete(line_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking line_item changes.

  ## Examples

      iex> change_line_item(line_item)
      %Ecto.Changeset{source: %LineItem{}}

  """
  def change_line_item(%LineItem{} = line_item) do
    LineItem.changeset(line_item, %{})
  end
end
