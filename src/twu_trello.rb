class TWUTrello

  def self.create events, trello_board_name
    board = Trello::Board.create(:name => trello_board_name)
    list_id = board.lists.first.id
    events.each do |event|
      card = Trello::Card.create(:name => event.name, :desc => event.session_link, :list_id => list_id)
      card.due = Time.iso8601(event.ending_time.to_s)
      card.update!
    end
  end

end
