defmodule Yaeta.Transactions.Expense do
  use Ecto.Schema
  import Ecto.Changeset


  schema "expenses" do
    field :amount, :decimal
    field :category, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:description, :category, :amount])
    |> validate_required([:description, :category, :amount])
  end
end
