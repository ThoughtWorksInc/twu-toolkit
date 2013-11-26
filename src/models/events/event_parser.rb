require 'csv'
require 'date'

require 'models/events/event_factory'
require 'models/events/utils/date_resolver'

class EventParser
  def initialize
    @event_factory = EventFactory.new
    @date_resolver = DateResolver.new
  end

  def parse_events file, starting_date
    current_date = Date.parse(starting_date)
    create_events(file, current_date)
  end

  private
  def create_events file, current_date
    current_day_of_the_week = 'Friday'
    events = []
    CSV.foreach(file, { :headers => true }) do |row|
      current_date, current_day_of_the_week = @date_resolver.define_current_date(current_day_of_the_week, row[0], current_date)
      events << @event_factory.create(current_date, row[1], row[2], row[3], row[4], @date_resolver.current_week, @date_resolver.current_day_of_the_week)
    end
    events
  end

end

