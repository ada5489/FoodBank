require 'minitest/autorun' # We need Ruby's unit testing library
require_relative 'Recipe'

class RecipeTest < MiniTest::Test
  def setup
    @bread = BasicFood.new('Bread', 80)
    @pb = BasicFood.new('Peanut Butter', 175)
    @jelly = BasicFood.new('Jelly', 155)
    @recipe = Recipe.new('PB&J', [@bread, @pb, @jelly, @bread])
  end

  # Tests the initial construction of a Recipe
  def test_construction
    assert_equal(@recipe.calories, 490)
  end

  # Tests the 'to_s' method of Recipe
  def test_to_s
    printf(@recipe.to_s)
  end
end
