require 'models/events/event'

class EventFactory
  INDIAN_UTC_TIMEZONE = "+5:30"
  def create date, time, name, link, type
    starting_hour, ending_hour = time.split(" till ")
    starting_date_time = DateTime.parse("#{date.to_s} #{starting_hour} #{INDIAN_UTC_TIMEZONE}")
    ending_date_time = DateTime.parse("#{date.to_s} #{ending_hour} #{INDIAN_UTC_TIMEZONE}")
    
    Event.new(starting_date_time, ending_date_time, name, link, type)
  end
end
