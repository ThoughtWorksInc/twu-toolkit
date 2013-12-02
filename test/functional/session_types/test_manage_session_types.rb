require 'test_helper'

class TestManageSessionTypes < BaseTest
  def test_create_session 
    visit '/session_types'

    fill_in('Name', :with => 'new session type')
    fill_in('Description', :with => 'this is a new session type')

    click_on('Create Session Type')
  end

end


