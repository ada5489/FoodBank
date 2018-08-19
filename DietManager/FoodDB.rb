# require './BasicFood'
require './Recipe'

class FoodDB
  attr_reader :size, :basicFoods, :recipes

  # filename is the name of the FoodDB file to be used, ex: "FoodDB.txt"
  def initialize(filename)
    @size = 0

    @dbFile = File.new(filename) # Open the database file

    @basicFoods = []
    @recipes = []

    # Read in the FoodDB file
    @dbFile.each do |line|
      values = line.split(',') # Split the line up at the commas

      if values[1] == 'b' # BasicFood case
        add_basicFood(values[0], values[2].to_i) # Add the new food to our list
      elsif values[1] == 'r' # Recipe case
        values[2..values.length].each(&:chomp!) # Remove newline characters
        add_recipe(values[0], values[2..values.length]) # Add the new Recipe to the recipes list
      else # The entry is invalid
        values[0].chomp.eql?('') ? nil : puts('Invalid food type found in FoodDB.txt')
      end
    end
  end

  # Returns true if a BasicFood with the name foodName exists in the database
  def contains_food?(_foodName)
    get_food(_foodName).nil? ? false : true
  end

  # Returns true if a Recipe with the name recipeName exists in the database
  def contains_recipe?(_recipeName)
    get_recipe(_recipeName).nil? ? false : true
  end

  # Returns true if there exists some entry in the database with the name itemName
  def contains?(itemName)
    result = contains_food?(itemName)
    unless result
      result = contains_recipe?(itemName)
    end
    result
  end

  # Returns the BasicFood of the given name if it exists within the database, nil otherwise
  def get_food(foodName)
    food = nil
    @basicFoods.each {|i|
      if i.getName == foodName
        food = i
        return food
      end
    }
    food
  end

  # Returns the Recipe of the given name if it exists within the database, nil otherwise
  def get_recipe(recipeName)
    recipe = nil
    @recipes.each {|i|
      if i.name == recipeName
        recipe = i
        return recipe
      end
    }
    recipe
  end

  # Returns the item of the given name if it exists within the database, nil otherwise
  def get(itemName)
    # If the item is a BasicFood and is in the database, return it
    # Else, if the item is a Recipe and is in the database, return it
    # Return nil otherwise
    item = get_food(itemName)
    if item.nil?
      item = get_recipe(itemName)
    end
    item
  end

  # Returns a list of all items in the database that begin with the given prefix
  def find_matches(prefix)
    list = []
    for i in @basicFoods
      if i.getName.include?(prefix)
        list.push(i)
      end
    end
    for x in @recipes
      if x.name.include?(prefix)
        list.push(x)
      end
    end
    list
  end

  # Constructs a new BasicFood and adds it to the database, returns true if successful, false otherwise
  def add_basicFood(_name, _calories)
    # Don't add if it is already in the database
    result = false
    unless contains_food?(_name)
      basicFoods.push(BasicFood.new(_name, _calories))
      @size += 1
      return true
    end
    result
  end

  # Constructs a new Recipe and adds it to the database, returns true if successful, false otherwise
  def add_recipe(_name, _ingredientNames)
    # Don't add if it is already in the database
    result = false
    ingredientNames = []
    for i in _ingredientNames
      if contains_food?(i)
        x = get(i)
        ingredientNames.push(x)
      end
    end
    unless contains_recipe?(_name)
      recipes.push(Recipe.new(_name, ingredientNames))
      @size += 1
      return true
    end
    result
  end

  # Saves the database to @dbFile
  def save
    File.open(@dbFile, 'w+') do |fOut|
      # Write all BasicFoods to the database
      @basicFoods.each { |food| fOut.write("#{food.name},b,#{food.calories}\n") }
      fOut.write("\n")

      # Write all Recipes to the database
      @recipes.each do |recipe|
        fOut.write("#{recipe.name},r")

        # List the ingredients after the recipe name
        recipe.ingredients.each { |ingredient| fOut.write(",#{ingredient.name}") }
        fOut.write("\n")
      end
    end
  end
end
