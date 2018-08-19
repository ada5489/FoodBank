require 'minitest/autorun' # We need Ruby's unit testing library
require './FoodDB'

class FoodDBTest < MiniTest::Test
  def setup # setup method is run automatically before each test_xxx
    @fdb = FoodDB.new('FoodDB.txt')
  end

  # Tests if there are entries in the DB after FoodDB.txt is read
  def test_DB_initialization
    assert(@fdb.size > 0, 'Database entries not correctly read in')
  end

  # Tests the 'contains_food?' method of FoodDB
  def test_contains_food
    assert_equal(false, @fdb.contains_food?('milk'))
    assert_equal(true, @fdb.contains_food?('Chicken'))
    assert_equal(true, @fdb.contains_food?('Apple'))
    assert_equal(false, @fdb.contains_food?('Jam'))
  end

  # Tests the 'contains_recipe?' method of FoodDB
  def test_contains_recipe
    assert_equal(true, @fdb.contains_recipe?('Chicken Sandwich'))
    assert_equal(false, @fdb.contains_recipe?('sausage and egg'))
    assert_equal(true, @fdb.contains_recipe?('PB&J Sandwich'))
    assert_equal(false, @fdb.contains_recipe?('salsa'))
  end

  # Tests the 'contains?' method of FoodDB
  def test_contains
    assert_equal(true, @fdb.contains?('PB&J Sandwich'))
    assert_equal(true, @fdb.contains?('Chicken Sandwich'))
    assert_equal(true, @fdb.contains?('Apple'))
    assert_equal(true, @fdb.contains?('Chicken'))
    assert_equal(false, @fdb.contains?('milk'))
    assert_equal(false, @fdb.contains?('Jam'))
  end

  # Tests the 'get_food' method of FoodDB
  def test_get_food
    assert_equal(50, @fdb.get_food('Apple').getCalories)
    assert_equal('Chicken 245', @fdb.get_food('Chicken').to_s)
    assert_equal('Jelly 155', @fdb.get_food('Jelly').to_s)
  end

  # Tests the 'get_recipe' method of FoodDB
  def test_get_recipe
    assert_equal('Chicken Sandwich', @fdb.get_recipe('Chicken Sandwich').getName)
    assert_equal('PB&J Sandwich', @fdb.get_recipe('PB&J Sandwich').getName)
  end

  # Tests the 'get' method of FoodDB
  def test_get
    assert_equal('Apple 50', @fdb.get('Apple').to_s)
    assert_equal('Chicken 245', @fdb.get('Chicken').to_s)
    assert_equal('Jelly 155', @fdb.get('Jelly').to_s)
    assert_equal(405, @fdb.get('Chicken Sandwich').getCalories)
    assert_equal(490, @fdb.get('PB&J Sandwich').getCalories)
  end

  # Tests the 'find_matches' method of FoodDB
  def test_find_matches
    assert_equal(1, @fdb.find_matches('App').length)
    assert_equal(2, @fdb.find_matches('C').length)
    assert_equal(2, @fdb.find_matches('P').length)
    assert_equal(1, @fdb.find_matches('O').length)
    assert_equal(1, @fdb.find_matches('Ora').length)
    assert_equal(1, @fdb.find_matches('W').length)
  end

  # Tests the 'add_basicFood' method
  def test_add_food
    assert_equal(true, @fdb.add_basicFood('Water', 0))
    assert_equal(true, @fdb.add_basicFood('Rice', 100))
    assert_equal(false, @fdb.add_basicFood('Jelly', 155))
  end

  # Tests the 'add_recipe' method
  def test_add_recipe
    assert_equal(true, @fdb.add_recipe('Rice and Beans', %w[Rice Water]))
  end

  # Tests the addition of a Recipe with a Recipe as one of its ingredients
  def test_recipe_within_recipe
    assert_equal(true, @fdb.add_recipe('Rice and Beans', %w[Rice Water]))
  end
end
