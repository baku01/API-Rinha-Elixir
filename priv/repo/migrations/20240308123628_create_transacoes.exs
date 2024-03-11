defmodule ApiElixirRinha.Repo.Migrations.CreateTransacoes do
  use Ecto.Migration

  def change do
    create table(:transacoes) do
      add :valor, :integer
      add :tipo, :string
      add :descricao, :text
      add :cliente_id, references(:cliente, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end
    create index(:transacoes, [:cliente_id])
  end
end
