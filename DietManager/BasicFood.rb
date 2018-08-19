class BasicFood
  attr_accessor :name, :calories

  # foodName is the name of the BasicFood and calories is the number of calories in this BasicFood
  def initialize(foodName, calories)
    @name = foodName
    @calories = calories
  end

  def getCalories
    @calories
  end

  def getName
    @name
  end

  # Returns a string representation of this BasicFood formatted for printing
  def to_s
    "#{@name} #{@calories}"
  end
end
