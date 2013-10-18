require 'test_helper'

class TestDateResolver < Test::Unit::TestCase

  def test_time_overlap_friday_monday
    current_date, day_of_the_week = DateResolver.new.define_current_date('Friday', 'Monday', Date.parse('2013-10-18'))
    assert_equal Date.parse('2013-10-21'), current_date
    assert_equal 'Monday', day_of_the_week
  end

  def test_time_overlap_friday_saturday
    current_date, day_of_the_week = DateResolver.new.define_current_date('Friday', 'Saturday', Date.parse('2013-10-18'))
    assert_equal Date.parse('2013-10-19'), current_date
    assert_equal 'Saturday', day_of_the_week
  end
  
  def test_time_overlap_saturday_monday
    current_date, day_of_the_week = DateResolver.new.define_current_date('Saturday', 'Monday', Date.parse('2013-10-19'))
    assert_equal Date.parse('2013-10-21'), current_date
    assert_equal 'Monday', day_of_the_week
  end

  def test_time_overlap_saturday_sunday
    current_date, day_of_the_week = DateResolver.new.define_current_date('Sunday', 'Monday', Date.parse('2013-10-20'))
    assert_equal Date.parse('2013-10-21'), current_date
    assert_equal 'Monday', day_of_the_week
  end

  def test_no_time_overlap
    current_date, day_of_the_week = DateResolver.new.define_current_date('Friday', 'Friday', Date.parse('2013-10-18'))
    assert_equal Date.parse('2013-10-18'), current_date
    assert_equal 'Friday', day_of_the_week
  end
  
  def test_one_day_overlap
    current_date, day_of_the_week = DateResolver.new.define_current_date('Monday', 'Tuesday', Date.parse('2013-10-21'))
    assert_equal Date.parse('2013-10-22'), current_date
    assert_equal 'Tuesday', day_of_the_week
  end

  def test_should_support_spaces
    current_date, day_of_the_week = DateResolver.new.define_current_date('Saturday ', 'Monday', Date.parse('2013-10-26'))
    assert_equal Date.parse('2013-10-28'), current_date
    assert_equal 'Monday', day_of_the_week
  end

  def test_should_support_lowercase
    current_date, day_of_the_week = DateResolver.new.define_current_date('saturday ', 'monday', Date.parse('2013-10-26'))
    assert_equal Date.parse('2013-10-28'), current_date
    assert_equal 'Monday', day_of_the_week
  end


end
