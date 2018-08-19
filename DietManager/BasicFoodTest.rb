require 'minitest/autorun' # We need Ruby's unit testing library
require_relative './BasicFood'

class BasicFoodTest < MiniTest::Test
  def setup
    @food = BasicFood.new('Chicken Wing', 300)
  end

  # Tests the initial construction of a BasicFood
  def test_construction
    assert(@food.name.eql?('Chicken Wing'), 'Name field was not initialized correctly')
    assert(@food.calories == 300, 'Calories field was not initialized correctly')
  end

  # Tests the 'to_s' method of BasicFood
  def test_to_s
    assert(@food.to_s.eql?('Chicken Wing 300'), 'to_s method formats string improperly')
  end
end
