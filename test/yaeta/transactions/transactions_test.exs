defmodule Yaeta.TransactionsTest do
  use Yaeta.DataCase

  alias Yaeta.Transactions

  describe "expenses" do
    alias Yaeta.Transactions.Expense

    @valid_attrs %{amount: "120.5", category: "some category", description: "some description"}
    @update_attrs %{amount: "456.7", category: "some updated category", description: "some updated description"}
    @invalid_attrs %{amount: nil, category: nil, description: nil}

    def expense_fixture(attrs \\ %{}) do
      {:ok, expense} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transactions.create_expense()

      expense
    end

    test "list_expenses/0 returns all expenses" do
      expense = expense_fixture()
      assert Transactions.list_expenses() == [expense]
    end

    test "get_expense!/1 returns the expense with given id" do
      expense = expense_fixture()
      assert Transactions.get_expense!(expense.id) == expense
    end

    test "create_expense/1 with valid data creates a expense" do
      assert {:ok, %Expense{} = expense} = Transactions.create_expense(@valid_attrs)
      assert expense.amount == Decimal.new("120.5")
      assert expense.category == "some category"
      assert expense.description == "some description"
    end

    test "create_expense/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_expense(@invalid_attrs)
    end

    test "update_expense/2 with valid data updates the expense" do
      expense = expense_fixture()
      assert {:ok, expense} = Transactions.update_expense(expense, @update_attrs)
      assert %Expense{} = expense
      assert expense.amount == Decimal.new("456.7")
      assert expense.category == "some updated category"
      assert expense.description == "some updated description"
    end

    test "update_expense/2 with invalid data returns error changeset" do
      expense = expense_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_expense(expense, @invalid_attrs)
      assert expense == Transactions.get_expense!(expense.id)
    end

    test "delete_expense/1 deletes the expense" do
      expense = expense_fixture()
      assert {:ok, %Expense{}} = Transactions.delete_expense(expense)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_expense!(expense.id) end
    end

    test "change_expense/1 returns a expense changeset" do
      expense = expense_fixture()
      assert %Ecto.Changeset{} = Transactions.change_expense(expense)
    end
  end

  describe "categories" do
    alias Yaeta.Transactions.Category

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transactions.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Transactions.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Transactions.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Transactions.create_category(@valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, category} = Transactions.update_category(category, @update_attrs)
      assert %Category{} = category
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_category(category, @invalid_attrs)
      assert category == Transactions.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Transactions.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Transactions.change_category(category)
    end
  end
end
