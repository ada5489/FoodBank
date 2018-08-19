require './LogItem'

class Log
  attr_accessor :size

  # filename is the name of the Log file to be used
  def initialize(filename)
    @log = {}
    @size = 0

    @logFile = File.new(filename) # Open the log file

    # Read in the Log file
    @logFile.each do |line|
      values = line.split(',') # Split the line at the commas
      dateParts = values[0].split('/') # Split the date field up at the slashes

      date = Date.parse("#{dateParts[2]}-#{dateParts[0]}-#{dateParts[1]}") # Parse the date string into a valid Date object

      add_logItem(values[1].chomp!, date)
    end
  end

  def getMap
    @log
  end

  # Adds a LogItem to the Log for the given date and name, returns true if successful, false otherwise
  def add_logItem(_name, _date)
    # If there are already entries for logItem's date, add the LogItem
    # Otherwise add a new entry for logItem's date and add the LogItem to its list
    result = false
    if @log.key?(_date)
      @log[_date].push(LogItem.new(_name, _date))
      @size += 1
      return true
    else
      @log[_date] = []
      @log[_date].push(LogItem.new(_name, _date))
      @size += 1
      return true
    end
    result
  end

  # Removes a LogItem from the Log for the given date and name
  def remove_logItem(_name, _date)
    if @log.has_key?(_date)
      for i in @log[_date]
        next unless i.name == _name
        @size -= 1
        @log[_date].delete(i)
        item = i
        return item
      end
    end
  end

  # Returns true if there is an entry for this date with the given name, false otherwise
  def contains?(_name, _date)
    if (@log.has_key?(_date))
      for i in @log[_date]
        if i.name == _name
          return true
        end
      end
    else
      return false
    end
    return false
  end

  def getList
    @log
  end

  # Returns an Array of LogItems for the given date, nil if there are no entries for the date
  # If no date is passed, returns all entries in the Log
  def get_entries(date = nil)
    if date.nil?
      list = []
      for i in @log
        list.push(i)
      end
    elsif @log[date].nil?
      list = nil
    else
      list = @log[date]
    end
    list
  end

  # Saves the log to @logFile
  def save
    # Write all save data to the log file
    File.open(@logFile, 'w+') do |fOut|
      get_entries.flatten.each do |logItem|
        fOut.write(logItem.to_s)
        fOut.write("\n")
      end
    end
  end
end
