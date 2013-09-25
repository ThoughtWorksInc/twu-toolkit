require 'test/unit'
require '../src/event'
require '../src/event_factory'
require 'date'

class TestEventFactory < Test::Unit::TestCase
  def test_create_event_on_friday
    event_factory = EventFactory.new
    event = event_factory.create(Date.parse("2013-10-18"), "9AM till 10:30AM", "Welcome to TWU", "link", "Session")
    assert_equal event.starting_time, DateTime.parse("2013-10-18 9AM")
    assert_equal event.ending_time, DateTime.parse("2013-10-18 10:30AM")
  end
end
