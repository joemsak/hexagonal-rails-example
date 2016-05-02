require "test_helper"
require "./test/amounts/amount"

class AmountsTest < Minitest::Test
  def test_zero_equals_zero
    assert_equal(Cents[0], Dollars[0])
    assert_equal(Cents[0], Dollars[0.0])
  end

  def test_one_cent_not_equal_to_one_dollar
    refute_equal(Cents[1], Dollars[1])
    refute_equal(Cents[50], Dollars[1])
    refute_equal(Cents[5000], Dollars[5000])
  end

  def test_one_hundred_cents_equal_to_one_dollar
    assert_equal(Cents[100], Dollars[1])
    assert_equal(Dollars[1], Cents[100])
    assert_equal(Dollars[2], Cents[200])
    assert_equal(Cents[1000], Dollars[10])
    assert_equal(Cents[1050], Dollars[10.50])
  end

  def test_amounts_equal_to_numbers
    assert_equal(Cents[100], 100)
    assert_equal(Dollars[1], 1)
    assert_equal(Dollars[2], 2)
    assert_equal(Cents[1000], 1000)
    assert_equal(Cents[1050], 1050)
    assert_equal(1050, Cents[1050])
  end

  def test_add_dollars_and_cents
    assert_equal(300, Cents[150] + Dollars[1.5])
    assert_equal(150.01, Dollars[150] + Cents[1])
  end

  def test_add_amounts_and_numbers
    assert_equal(150, 100 + Cents[50])
    assert_equal(300, Cents[150] + 150)
    assert_equal(150.01, Dollars[150] + 0.01)
  end
end
