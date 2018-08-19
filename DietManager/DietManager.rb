require './FoodDB'
require './Log'

class DietManager
  def initialize
    @dbFile = 'FoodDB.txt'
    @logFile = 'DietLog.txt'
    @database = FoodDB.new(@dbFile)
    @log = Log.new(@logFile)
    @dbChanged = false
    @logChanged = false
  end

  # Handles the 'quit' command which exits the DietManager
  def command_quit
    # command_save
    abort
  end

  # Handles the 'save' command which saves the FoodDB and Log if necessary
  def command_save
    @database.save
    @log.save
  end

  # Handles the 'new food' command which adds a new BasicFood to the FoodDB
  def command_newFood(name, calories)
    if @database.contains_food?(name)
      puts 'Food already in database'
    else
      @database.add_BasicFood(name, calories)
      # command_save
      @dbChanged = true
    end
  end

  # Handles the 'new recipe' command which adds a new Recipe to the FoodDB
  def command_newRecipe(name, ingredients)
    if @database.contains_recipe?(name)
      puts 'Recipe already in database'
    else
      @ddatabase.add_recipe(name, ingredients)
      # command_save
      @dbChanged = true
    end
  end

  # Handles the 'print' command which prints a single item from the FoodDB
  def command_print(name)
    command_find(name)
  end

  # Handles the 'print all' command which prints all items in the FoodDB
  def command_printAll
    for i in @database.basicFoods
      puts i.to_s
    end
    puts $INPUT_RECORD_SEPARATOR
    for r in @database.recipes
      puts r.to_s
    end
    puts $INPUT_RECORD_SEPARATOR
  end

  # Handles the 'find' command which prints information on all items in the FoodDB matching a certain prefix
  def command_find(prefix)
    for i in @database.find_matches(prefix)
      puts i.to_s
    end
    #puts $INPUT_RECORD_SEPARATOR
  end

  # Handles both forms of the 'log' command which adds a unit of the named item to the log for a certain date
  def command_log(name, date = Date.today)
    @log.add_logItem(name, date)
    # command_save
    @logChanged = true
  end

  # Handles the 'delete' command which removes one unit of the named item from the log for a certain date
  def command_delete(name, date)
    @log.remove_logItem(name, date)
    # command_save
    @logChanged = true
  end

  # Handles both forms of the 'show' command which displays the log of items for a certain date
  def command_show(date = Date.today)
    _date = date.split('/')
    date_ = Date.parse("#{_date[2]}-#{_date[0]}-#{_date[1]}")
    @log.get_entries(date_).each do |i|
      puts i.name
    end
    puts $INPUT_RECORD_SEPARATOR
  end

  # Handles the 'show all' command which displays the entire log of items
  def command_showAll
    @log.getMap.each_key do |key|
      puts key.strftime('%m/%d/%Y')
      @log.get_entries(key).each do |i|
        puts "  #{i.name}"
      end end
    puts $INPUT_RECORD_SEPARATOR
  end
end # end DietManager class

# MAIN

dietManager = DietManager.new

puts 'Input a command > '

# Read commands from the user through the command prompt
$stdin.each  do |line|
  split = line.split(' ')
  puts $INPUT_RECORD_SEPARATOR
  case split[0]
  when 'log'
    x = split[1].split(',')
    if x.size > 1
      dietManager.command_log(x[1], x[2])
    else
      dietManager.command_log(x[1], Date.today)
    end
  when 'delete'
    dietManager.command_delete(split[1], split[2])
  when 'show'
    if split[1] == 'all'
      dietManager.command_showAll
    else
      dietManager.command_show(split[1])
    end
  when 'quit'
    dietManager.command_quit
  when 'new'
    x = split[2].split(',')
    if split[1] == 'food'
      dietManager.command_newFood(x[0], x[1])
    else
      a = split[2,]
      dietManager.command_newRecipe(x[0], a)
    end
  when 'print'
    if split[1] == 'all'
      dietManager.command_printAll
    else
      dietManager.command_print(split[1])
    end
  when 'find'
    dietManager.command_find(split[1])
  end
end

