class CategoryTotal
  def self.call(expense_class, category)
    expense_class.by_category(category).collect(&:amount).reduce(:+)
  end
end
