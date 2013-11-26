class DateResolver
  attr_reader :current_week, :current_day_of_the_week

  def initialize
    @current_week = 0
    @current_day_of_the_week = 'Friday'
  end

  def define_current_date current_day_of_the_week, next_day_of_the_week, current_date
    if day_of_the_week_changed?(current_day_of_the_week, next_day_of_the_week) then
      day_offset = calculate_day_offset(current_day_of_the_week, next_day_of_the_week)
      current_date = current_date.next_day(day_offset)
      current_day_of_the_week = next_day_of_the_week 
      @current_day_of_the_week = current_day_of_the_week
    end
    [current_date, current_day_of_the_week.strip.capitalize]
  end

  private
  def day_of_the_week_changed?(current_day_of_the_week, possibly_the_next_day)
    possibly_the_next_day != current_day_of_the_week && !possibly_the_next_day.nil?
  end

  def calculate_day_offset(current_day_of_the_week, next_day_of_the_week)
    current_day, next_day  = current_day_of_the_week.downcase.strip, next_day_of_the_week.downcase.strip
    if next_day == 'monday' then
      @current_week += 1
      return 3 if current_day == 'friday' 
      return 2 if current_day == 'saturday' 
    end
    return 1
  end

end
