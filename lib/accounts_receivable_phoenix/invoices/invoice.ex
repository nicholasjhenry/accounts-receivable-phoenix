defmodule AccountsReceivablePhoenix.Invoices.Invoice do
  use Ecto.Schema
  import Ecto.Changeset
  alias AccountsReceivablePhoenix.Clients.Client

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "invoices" do
    field :net_days, :integer
    field :note, :string
    belongs_to :client, Client

    timestamps()
  end

  @doc false
  def changeset(invoice, attrs) do
    invoice
    |> cast(attrs, [:net_days, :note])
    |> validate_required([:net_days, :note])
  end
end
