class Expense
  @@expenses = []

  attr_reader :category, :amount

  def initialize(attributes = {})
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  class << self
    def all
      @@expenses
    end

    def by_category(category)
      all.select { |e| e.category == category }
    end

    def first
      all[0]
    end

    def push(expense)
      if expense.amount > 0
        @@expenses << expense
      end
    end

    def setup
      @@expenses = []
    end
  end
end
