defmodule Yaeta.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses) do
      add :description, :string
      add :category, :string
      add :amount, :decimal

      timestamps()
    end

  end
end
