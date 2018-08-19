require './BasicFood'

class Recipe
  attr_accessor :name, :ingredients, :calories

  # recipeName is the name of this recipe and ingredientsList is the list of BasicFood objects in this recipe
  def initialize(recipeName, ingredientsList)
    @name = recipeName
    @ingredients = ingredientsList.sort { |x, y| x.getName <=> y.getName } # Sorts the list by ingredient name
    @calories = 0
    ingredients.each do |i|
      @calories += i.getCalories
    end
  end

  def getCalories
    @calories
  end

  def getName
    @name
  end

  # Returns a string representation of this Recipe formatted for printing
  def to_s
    result = "#{@name}   #{@calories}"
    result += $/
    ingredients.each do |food|
      result += "    #{food.to_s}"
      result += $/
    end
    result
  end
end
