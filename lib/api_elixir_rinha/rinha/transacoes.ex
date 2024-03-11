defmodule ApiElixirRinha.Rinha.Transacoes do
  use Ecto.Schema
  import Ecto.Changeset
  alias ApiElixirRinha.Repo

  schema "transacoes" do
    field :valor, :integer
    field :tipo, :string
    field :descricao, :string
    belongs_to :cliente, ApiElixirRinha.Rinha.Cliente

    timestamps(type: :utc_datetime)
  end

  def changeset(transacoes, attrs) do
    transacoes
    |> cast(attrs, [:valor, :tipo, :descricao, :cliente_id])
    |> validate_required([:valor, :tipo, :descricao])
    |> validate_inclusion(:tipo, ["c", "d"])
    |> validate_length(:descricao, min: 0, max: 20)
    |> validate_transacao()
  end

  defp validate_transacao(changeset) do
    tipo = get_field(changeset, :tipo)

    cond do
      changeset.valid? and tipo == "c" ->
        validate_credito(changeset)
      changeset.valid? and tipo == "d" ->
        validate_debito(changeset)
      true ->
        changeset
    end
  end

  defp validate_credito(changeset) do
    credito = get_field(changeset, :valor)
    cliente = Repo.get!(ApiElixirRinha.Rinha.Cliente, get_field(changeset, :cliente_id))

    if credito + cliente.saldo > cliente.limite do
      add_error(changeset, :valor, "o credito não pode ser maior que o limite do cliente")
    else
      add_to_saldo(cliente, credito)
      changeset
    end
  end

  defp validate_debito(changeset) do
    debito = get_field(changeset, :valor)
    cliente = Repo.get!(ApiElixirRinha.Rinha.Cliente, get_field(changeset, :cliente_id))

    if debito - cliente.saldo > cliente.saldo do
      add_error(changeset, :valor, "O debito não pode ser maior que o saldo do cliente")
    else
      subtract_from_saldo(cliente, debito)
      changeset
    end
  end

  defp add_to_saldo(cliente, valor) do
    cliente
    |> Ecto.Changeset.change(%{saldo: cliente.saldo + valor})
    |> Repo.update()
  end

  defp subtract_from_saldo(cliente, valor) do
    cliente
    |> Ecto.Changeset.change(%{saldo: cliente.saldo - valor})
    |> Repo.update()
  end
end
