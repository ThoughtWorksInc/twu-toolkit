require 'csv'

class EventParser
  def self.parse_events
    events = []
    CSV.foreach(FILE, { :headers => true }) do |row|
      events << Event.new(row[1], row[2], row[3], row[4], row[5], row[6])
    end
    events
  end
end

