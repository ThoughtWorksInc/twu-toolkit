require 'test_helper'

class TestCreateTrello < BaseTest

  def test_create_trello_happy_path
    visit '/trello'
    click_link 'Grant Permission'
    
    fill_in('Name', :with => 'Trello Name')
    fill_in('TWU Start Date', :with => '2013-10-18')
    attach_file('CSV calendar', File.expand_path('test/functional/resources/test_calendar.csv'))
    click_on('Create Trello')

    created_cards = TrelloApiMock::Card.created_cards 

    assert_equal "Alcohol & Drug Guidelines", created_cards[0][:name]
    assert_equal "Pune City Tour", created_cards[1][:name]
    assert_equal '! Calendar succesfully create', find(:text, '.notice').text
  end

end
 
