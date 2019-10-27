defmodule AccountsReceivablePhoenix.Repo.Migrations.CreateInvoices do
  use Ecto.Migration

  def change do
    create table(:invoices, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :net_days, :integer, null: false
      add :note, :string
      add :client_id, references(:clients, type: :binary_id), null: false

      timestamps()
    end

    create index(:invoices, [:client_id])
  end
end
