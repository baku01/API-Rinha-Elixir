defmodule ApiElixirRinha.Repo.Migrations.CreateCliente do
  use Ecto.Migration

  def change do
    create table(:cliente) do
      add :limite, :integer
      add :saldo, :integer

      timestamps(type: :utc_datetime)
    end
  end
end