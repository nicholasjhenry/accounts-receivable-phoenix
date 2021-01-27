defmodule AccountsReceivablePhoenix.Invoices.Invoice do
  use Ecto.Schema
  import Ecto.Changeset
  alias AccountsReceivablePhoenix.Clients.Client
  alias AccountsReceivablePhoenix.Invoices.LineItem

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "invoices" do
    field :net_days, :integer
    field :note, :string
    belongs_to :client, Client
    has_many :product_line_items, LineItem, where: [product_id: {:not, nil}]
    has_many :service_line_items, LineItem, where: [service_id: {:not, nil}]

    field :due_date, :date, virtual: true

    timestamps()
  end

  @doc false
  def changeset(invoice, attrs) do
    invoice
    |> cast(attrs, [:net_days, :note, :client_id])
    |> validate_required([:net_days, :note, :client_id])
    |> foreign_key_constraint(:client_id)
  end

  def calculate(invoice) do
    due_date = Date.add(invoice.inserted_at, invoice.net_days)

    %{invoice | due_date: due_date}
  end
end
