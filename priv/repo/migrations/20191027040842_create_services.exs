defmodule AccountsReceivablePhoenix.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :price_cents, :integer, null: false

      timestamps()
    end
  end
end
