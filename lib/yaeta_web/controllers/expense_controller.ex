defmodule YaetaWeb.ExpenseController do
  use YaetaWeb, :controller

  alias Yaeta.Transactions
  alias Yaeta.Transactions.Expense

  def index(conn, _params) do
    expenses = Transactions.list_expenses()

    total = expenses
    |> Enum.reduce(Decimal.new(0), fn(x, acc) -> Decimal.add(acc, x.amount) end )

    render(conn, "index.html", expenses: expenses, total: total)
  end

  def new(conn, _params) do

    categories = Transactions.list_categories()
    categories = categories |> Enum.map( &(&1.name))

    changeset = Transactions.change_expense(%Expense{})
    render(conn, "new.html", changeset: changeset, categories: categories)
  end

  def create(conn, %{"expense" => expense_params}) do
    case Transactions.create_expense(expense_params) do
      {:ok, expense} ->
        conn
        |> put_flash(:info, "Expense created successfully.")
        |> redirect(to: expense_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    expense = Transactions.get_expense!(id)
    render(conn, "show.html", expense: expense)
  end

  def edit(conn, %{"id" => id}) do
    expense = Transactions.get_expense!(id)
    changeset = Transactions.change_expense(expense)

    categories = Transactions.list_categories()
    categories = categories |> Enum.map( &(&1.name))

    render(conn, "edit.html", expense: expense, changeset: changeset, categories: categories)
  end

  def update(conn, %{"id" => id, "expense" => expense_params}) do
    expense = Transactions.get_expense!(id)

    case Transactions.update_expense(expense, expense_params) do
      {:ok, expense} ->
        conn
        |> put_flash(:info, "Expense updated successfully.")
        |> redirect(to: expense_path(conn, :show, expense))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", expense: expense, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    expense = Transactions.get_expense!(id)
    {:ok, _expense} = Transactions.delete_expense(expense)

    conn
    |> put_flash(:info, "Expense deleted successfully.")
    |> redirect(to: expense_path(conn, :index))
  end
end
