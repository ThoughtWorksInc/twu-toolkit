
class Event
  attr_reader :month, :day, :time, :name, :session_link, :type
  def initialize(month, day, time, name, session_link, type) 
    @month = month
    @day = day
    @time = time
    @name = name
    @link = session_link
    @type = type.to_sym
  end

  def to_calendar
  end

end


