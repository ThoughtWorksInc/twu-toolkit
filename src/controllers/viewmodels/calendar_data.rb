class CalendarData
  attr_accessor :errors, :calendar_csv, :calendar_name, :start_date
  
  def initialize params
    @calendar_csv = params['calendar_csv'][:tempfile] if !params['calendar_csv'].nil?
    @calendar_name = params[:calendar_name]
    @start_date = params[:calendar_start_date]
    @errors = {}
  end

  def is_valid?
    ![@calendar_csv, @calendar_name, @start_date].include? nil
  end

  def has_errors?
    find_errors
    !@errors.empty?
  end

  def find_errors
    @errors[:calendar_csv] = "You must enter a csv calendar" if @calendar_csv.nil?
    @errors[:calendar_name] = "You must enter a calendar name" if @calendar_name.nil? || @calendar_name.empty?
    @errors[:start_date] = "You must enter a start date" if @start_date.nil? || @start_date.empty?
  end
end

