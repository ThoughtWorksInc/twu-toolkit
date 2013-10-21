require 'test_helper'

class TestCreateCalendar < BaseTest

  def test_create_calendar_happy_path
    visit '/calendar'
    click_link 'Grant Permission'
    
    fill_in('Name', :with => 'Calendar Name')
    fill_in('TWU Start Date', :with => '2013-10-18')
    attach_file('CSV calendar', File.expand_path('test/functional/resources/test_calendar.csv'))
    click_on('Create Calendar')

    assert_equal '! Calendar succesfully create', find(:text, '.notice').text
  end

end
