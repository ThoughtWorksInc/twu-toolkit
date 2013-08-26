require_relative 'config'
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

  def event_name
    event_name = "#{name}" 
    event_name += " - #{presenters}" if !presenters.nil?
    event_name += " on #{month} #{day} #{time}"
    event_name
  end

end

def parse_events
  events = []
  CSV.foreach(FILE, { :headers => true }) do |row|
    events << Event.new(row[0], row[1], row[2], row[3], row[4])
  end
  events
end

def create_calendar(events)
  events.each do |event| 
    command = "google calendar add --cal #{CALENDAR} \"#{event.event_name}\""
    5.times do
      system(command)
      ($?.exitstatus != 0) ? sleep(5) : break
    end
  end
end

events = parse_events
create_calendar(events)

