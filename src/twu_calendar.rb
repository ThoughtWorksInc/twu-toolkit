=begin
def create_calendar(events)
  events.each do |event| 
    command = "google calendar add --cal #{CALENDAR} \"#{event.calendar_name}\""
    perform_command(command)
  end
end

def create_trello_board(events)
  events.each do |event|
    if event.has_presenters?
      command = "trello card create -b'#{TRELLO_BOARD_ID}' -n'#{event.trello_name}' -l'#{TRELLO_TODO_LIST_ID}'"
      puts command
      perform_command(command)
    end
  end
end
=end
