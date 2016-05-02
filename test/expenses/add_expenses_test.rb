require "test_helper"

require "./test/expenses/create_expense"
require "./test/expenses/expense"
require "./test/amounts/amount"
require "./test/categories/category_total"

class TestAddingExpenses < Minitest::Test
  def setup
    Expense.setup
    @create_expense = CreateExpense.new
  end

  def test_add_expense_for_zero_cents
    @create_expense.call(amount: Cents[0])
    assert_empty(Expense.all)
  end

  def test_add_expense_for_some_cents
    @create_expense.call(amount: Cents[1])
    assert_equal(1, Expense.first.amount.to_i)
    assert_equal("1 cents", Expense.first.amount.to_s)
    assert_equal("Cents[1]", Expense.first.amount.inspect)
  end

  def test_add_expense_for_negative_cents
    @create_expense.call(amount: Cents[-1])
    assert_empty(Expense.all)
  end

  def test_add_expense_for_category
    @create_expense.call(amount: Cents[100], category: 'Meals')
    @create_expense.call(amount: Cents[150], category: 'Meals')
    @create_expense.call(amount: Cents[150], category: 'Fun')
    assert_equal(250, CategoryTotal.call(Expense, 'Meals'))
    assert_equal(150, CategoryTotal.call(Expense, 'Fun'))
  end
end
