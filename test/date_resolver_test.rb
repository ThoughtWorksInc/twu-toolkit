require 'test/unit'
require '../src/date_resolver'
require 'date'

class TestDateResolver < Test::Unit::TestCase

  def test_time_overlap_friday_monday
    current_date, day_of_the_week = DateResolver.new.define_current_date('Friday', 'Monday', Date.parse('2013-10-18'))
    assert_equal current_date, Date.parse('2013-10-21')
    assert_equal day_of_the_week, 'Monday'
  end

  def test_no_time_overlap
    current_date, day_of_the_week = DateResolver.new.define_current_date('Friday', 'Friday', Date.parse('2013-10-18'))
    assert_equal current_date, Date.parse('2013-10-18')
    assert_equal day_of_the_week, 'Friday'
  end
  
  def test_one_day_overlap
    current_date, day_of_the_week = DateResolver.new.define_current_date('Monday', 'Tuesday', Date.parse('2013-10-21'))
    assert_equal current_date, Date.parse('2013-10-22')
    assert_equal day_of_the_week, 'Tuesday'
  end

end
