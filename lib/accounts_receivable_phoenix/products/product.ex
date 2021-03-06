defmodule AccountsReceivablePhoenix.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :name, :string
    field :price_cents, :integer

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price_cents])
    |> validate_required([:name, :price_cents])
  end
end
