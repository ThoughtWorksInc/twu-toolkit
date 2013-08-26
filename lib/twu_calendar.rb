require_relative '../config'
require 'csv'

class Event
  attr_reader :month, :day, :time, :name, :presenters
  def initialize(month, day, time, name, presenters) 
    @month = month
    @day = day
    @time = time
    @name = name
    @presenters = presenters
  end

  def has_presenters?
    !presenters.nil?
  end

  def calendar_name
    calendar_name = "#{name}" 
    calendar_name += " - #{presenters}" if has_presenters?
    calendar_name += " on #{month} #{day} #{time}"
    calendar_name
  end

  def trello_name
    "#{name} - #{presenters} due #{month} #{time}"
  end

end

def parse_events
  events = []
  CSV.foreach(FILE, { :headers => true }) do |row|
    events << Event.new(row[0], row[1], row[2], row[3], row[4])
  end
  events
end

def perform_command(command)
  5.times do
    system(command)
    ($?.exitstatus != 0) ? sleep(5) : break
  end
end

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

