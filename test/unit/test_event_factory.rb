require 'test_helper'

class TestEventFactory < Test::Unit::TestCase

  def test_create_event_on_friday
    event_factory = EventFactory.new
    event = event_factory.create(Date.parse("2013-10-18"), "9AM till 10:30AM", "Welcome to TWU", "link", "Session", 1, 'Friday')
    assert_equal event.starting_time, DateTime.parse("2013-10-18 9AM +5:30")
    assert_equal event.ending_time, DateTime.parse("2013-10-18 10:30AM +5:30")
  end
end
