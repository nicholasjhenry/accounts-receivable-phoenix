defmodule AccountsReceivablePhoenix.Invoices.LineItem do
  use Ecto.Schema
  import Ecto.Changeset

  alias AccountsReceivablePhoenix.Invoices.Invoice
  alias AccountsReceivablePhoenix.Products.Product
  alias AccountsReceivablePhoenix.Services.Service

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "line_items" do
    field :description, :string
    field :price_override_cents, :integer
    field :quantity, :integer
    belongs_to :invoice, Invoice
    belongs_to :product, Product
    belongs_to :service, Service

    timestamps()
  end

  @doc false
  def changeset(line_item, attrs) do
    line_item
    |> cast(attrs, [
      :price_override_cents,
      :quantity,
      :description,
      :invoice_id,
      :product_id,
      :service_id
    ])
    |> validate_required([:quantity, :invoice_id])
  end
end
