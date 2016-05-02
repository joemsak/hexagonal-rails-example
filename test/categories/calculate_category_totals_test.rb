require "test_helper"
require "./test/amounts/amount"
require "./test/expenses/expense"
require "./test/categories/category_total"

class TestExpense < Expense
  def self.all
    [new(amount: Cents[100], category: 'Meals'),
     new(amount: Dollars[1.50], category: 'Meals'),
     new(amount: Cents[150], category: 'Fun'),
     new(amount: Cents[1], category: 'Cheap')]
  end
end

class CalculateCategoryTotalsTest < Minitest::Test
  def test_add_expense_for_category
    assert_equal(Dollars[2.50], CategoryTotal.call(TestExpense, 'Meals'))
    assert_equal(Cents[150], CategoryTotal.call(TestExpense, 'Fun'))

    # HOWTO: make Cents[250] == 2.5
    assert_equal(Cents[250], CategoryTotal.call(TestExpense, 'Meals'))
  end
end
