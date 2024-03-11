defmodule ApiElixirRinha.Rinha.Cliente do
  use Ecto.Schema
  import Ecto.Changeset


  schema "cliente" do
    field :limite, :integer
    field :saldo, :integer
    has_many :transacoes, ApiElixirRinha.Rinha.Transacoes

    timestamps(type: :utc_datetime)
  end

  def changeset(cliente, attrs) do
    cliente
    |> cast(attrs, [:limite, :saldo])
    |> validate_required([:limite, :saldo])
    |> validate_saldo()
  end

  defp validate_saldo(changeset) do
    saldo = get_field(changeset, :saldo)
    limite = get_field(changeset, :limite)

    if saldo > limite do
      add_error(changeset, :saldo, "Saldo não pode ser maior que o limite")
    else
      changeset
    end
  end
end