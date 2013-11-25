class TWUTrelloService

  def self.create events, trello_board_name, session_types_to_include
    board = create_board(:name => trello_board_name)
    list_id = board.lists.first.id

    events.each do |event|
      if session_types_to_include.include?(event.type.to_s)
        card = create_card(:name => event.name, :desc => event.session_link, :list_id => list_id)
        card.due = due_time(event.ending_time.to_s)
        card.update!
      end
    end

  end

  private
  def self.create_card params
    Trello::Card.create(params)
  end

  def self.due_time time
    Time.iso8601(time)
  end

  def self.create_board params
    Trello::Board.create(params)
  end

end
