defmodule AccountsReceivablePhoenix.Repo.Migrations.CreateLineItems do
  use Ecto.Migration

  def change do
    create table(:line_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :price_override_cents, :integer
      add :quantity, :integer, default: 1, null: false
      add :description, :string
      add :invoice_id, references(:invoices, on_delete: :nothing, type: :binary_id), null: false
      add :product_id, references(:products, on_delete: :nothing, type: :binary_id)
      add :service_id, references(:services, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:line_items, [:invoice_id])
    create index(:line_items, [:product_id])
    create index(:line_items, [:service_id])
  end
end
