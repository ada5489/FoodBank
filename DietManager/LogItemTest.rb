require 'minitest/autorun' # We need Ruby's unit testing library
require_relative './LogItem'

class LogItemTest < MiniTest::Test
  def setup
    @item = LogItem.new('Orange', Date.today)
  end

  # Tests the basic construction of a LogItem object
  def test_construction
    assert_equal(@item.date, Date.today)
    assert_equal(@item.name, 'Orange')
  end

  # Tests the 'to_s' method of LogItem
  def test_to_s
    assert_equal(@item.to_s, "   #{Date.today}, Orange ")
  end
end
