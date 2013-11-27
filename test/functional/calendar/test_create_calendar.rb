require 'test_helper'

class TestCreateCalendar < BaseTest

  def test_create_calendar_happy_path
    visit '/calendar'
    click_link 'Grant Permission'
    
    fill_in('Name', :with => 'Calendar Name')
    fill_in('TWU Start Date', :with => '2013-10-18')
    attach_file('CSV calendar', File.expand_path('test/functional/resources/test_calendar.csv'))
    click_on('Create Calendar')

    google_api_mock = GoogleApiMock.get_mock

    assert_equal '! Calendar succesfully create', find(:text, '.notice').text

    assert_equal google_api_mock.events_inserted[0][:body], "{\"colorId\":\"1\",\"start\":{\"dateTime\":\"2013-10-18T09:00:00+05:30\"},\"end\":{\"dateTime\":\"2013-10-18T10:30:00+05:30\"},\"description\":\"https://my.thoughtworks.com/docs/DOC-17148\",\"summary\":\"Welcome to India\"}"
    assert_equal google_api_mock.events_inserted[2][:body], "{\"colorId\":\"1\",\"start\":{\"dateTime\":\"2013-10-18T14:30:00+05:30\"},\"end\":{\"dateTime\":\"2013-10-18T15:30:00+05:30\"},\"description\":null,\"summary\":\"Admin + Anti-Harrasment\"}"
  end

end
