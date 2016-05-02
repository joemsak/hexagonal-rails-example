class Amount
  class << self
    def [](magnitude)
      new(magnitude)
    end
  end

  attr_reader :magnitude

  def initialize(magnitude)
    @magnitude = magnitude
    freeze
  end

  def inspect
    "#{isolated_class_name}[#{magnitude}]"
  end

  def to_s
    "#{magnitude} #{isolated_class_name.downcase}"
  end

  def ==(other)
    if zero? && other.zero?
      true
    elsif !other.is_a?(Amount)
      to_i == other
    else
      super
    end
  end

  def >(other)
    to_i > other
  end

  def +(other)
    to_i + other.to_f
  end

  def zero?
    to_i.zero?
  end

  def coerce(other)
    [self.class.new(other), self]
  end

  alias_method :to_i, :magnitude
  alias_method :to_f, :magnitude

  private
  def isolated_class_name
    self.class.name.gsub(/^.*::/, '')
  end
end

class Cents < Amount
  def ==(other)
    if to_i / 100.0 == other.to_i
      true
    else
      super
    end
  end

  def +(other)
    if other.is_a?(Dollars)
      to_i + other.to_i * 100
    else
      super
    end
  end
end

class Dollars < Amount
  def ==(other)
    if to_i * 100 == other.to_i
      true
    else
      super
    end
  end

  def +(other)
    if other.is_a?(Cents)
      to_i + other.to_i / 100.0
    else
      super
    end
  end
end
