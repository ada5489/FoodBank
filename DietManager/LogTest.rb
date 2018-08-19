require 'minitest/autorun' # We need Ruby's unit testing library
require_relative './Log'

class LogTest < MiniTest::Test
  def setup
    @log = Log.new('DietLog.txt')
  end

  # Tests the basic construction of a Log object
  def test_construction
    assert(@log.size > 0, 'Log entries not correctly read in')
  end

  # Tests the 'add_logItem' method
  def test_add_logItem
    oldSize = @log.size

    assert(@log.add_logItem(Date.today, 'Bread Slice'), 'LogItem not added to log')
    assert(@log.add_logItem(Date.new, 'Jelly'), 'LogItem not added to log')
    assert(@log.size == oldSize + 2, 'Size attribute not updated correctly')
  end

  # Tests the 'get_entries' method by passing a date that is in the Log
  def test_get_entries
    entries = @log.get_entries(Date.parse('2011-02-08'))

    assert(!entries.nil?, 'No list of entries found for a date that should have entries')
    assert(!entries.empty?, 'No entries found when there should be at least 1')
    assert(entries[0].name.eql?('Orange'), 'First entry is incorrect')
  end

  # Tests the 'get_entries' method by passing a date that is not in the Log
  def test_get_entries_nil
    assert(@log.get_entries(Date.new).nil?, 'Entries returned for a date for which there should be no entries')
  end

  # Tests the 'get_entries' method without passing a date (all entries)
  def test_get_entries_no_date
    entries = @log.get_entries

    assert(!entries.nil?, 'No list of entries returned when the Log should not be empty')
    assert(!entries.empty?, 'Empty list of entries when there should be multiple entries in the Log')
  end

  # Tests the 'contains?' method
  def test_contains
    assert(@log.contains?('Apple', Date.parse('2008-09-12')), 'LogItem that should exist not found')
    assert(!@log.contains?('Jelly', Date.today), 'False positive, LogItem that does not exist found')
  end

  # Tests the 'remove_logItem' method
  def test_remove_logItem
    assert(@log.contains?('Apple', Date.parse('2008-09-12')), 'LogItem that should exist not found')
    assert(@log.remove_logItem('Apple', Date.parse('2008-09-12')).name.eql?('Apple'), 'Incorrect element removed from Log')
    assert(!@log.contains?('Apple', Date.parse('2008-09-12')), 'LogItem that should not exist was mistakenly found')
    assert(@log.remove_logItem('Jelly', Date.today).nil?, 'False positive, LogItem that does not exist was removed')
  end
end
