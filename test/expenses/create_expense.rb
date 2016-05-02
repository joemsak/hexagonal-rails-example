class CreateExpense
  attr_reader :expense_class

  def initialize(expense_class = Expense)
    @expense_class = expense_class
  end

  def call(attrs)
    expense = expense_class.new(attrs)
    expense_class.push(expense)
  end
end

