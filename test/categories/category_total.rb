class CategoryTotal
  def self.call(expense_class, category)
    expenses = expense_class.all.select { |e| e.category == category }
    expenses.inject(0) { |sum, expense| sum + expense.amount }
  end
end
