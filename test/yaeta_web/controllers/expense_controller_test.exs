defmodule YaetaWeb.ExpenseControllerTest do
  use YaetaWeb.ConnCase

  alias Yaeta.Transactions

  @create_attrs %{amount: "120.5", category: "some category", description: "some description"}
  @update_attrs %{amount: "456.7", category: "some updated category", description: "some updated description"}
  @invalid_attrs %{amount: nil, category: nil, description: nil}

  def fixture(:expense) do
    {:ok, expense} = Transactions.create_expense(@create_attrs)
    expense
  end

  describe "index" do
    test "lists all expenses", %{conn: conn} do
      conn = get conn, expense_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Expenses"
    end
  end

  describe "new expense" do
    test "renders form", %{conn: conn} do
      conn = get conn, expense_path(conn, :new)
      assert html_response(conn, 200) =~ "New Expense"
    end
  end

  describe "create expense" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, expense_path(conn, :create), expense: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == expense_path(conn, :show, id)

      conn = get conn, expense_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Expense"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, expense_path(conn, :create), expense: @invalid_attrs
      assert html_response(conn, 200) =~ "New Expense"
    end
  end

  describe "edit expense" do
    setup [:create_expense]

    test "renders form for editing chosen expense", %{conn: conn, expense: expense} do
      conn = get conn, expense_path(conn, :edit, expense)
      assert html_response(conn, 200) =~ "Edit Expense"
    end
  end

  describe "update expense" do
    setup [:create_expense]

    test "redirects when data is valid", %{conn: conn, expense: expense} do
      conn = put conn, expense_path(conn, :update, expense), expense: @update_attrs
      assert redirected_to(conn) == expense_path(conn, :show, expense)

      conn = get conn, expense_path(conn, :show, expense)
      assert html_response(conn, 200) =~ "some updated category"
    end

    test "renders errors when data is invalid", %{conn: conn, expense: expense} do
      conn = put conn, expense_path(conn, :update, expense), expense: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Expense"
    end
  end

  describe "delete expense" do
    setup [:create_expense]

    test "deletes chosen expense", %{conn: conn, expense: expense} do
      conn = delete conn, expense_path(conn, :delete, expense)
      assert redirected_to(conn) == expense_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, expense_path(conn, :show, expense)
      end
    end
  end

  defp create_expense(_) do
    expense = fixture(:expense)
    {:ok, expense: expense}
  end
end
