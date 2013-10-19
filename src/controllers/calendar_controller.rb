require 'models/events/event_parser'
require 'services/google_calendar_service'
require 'controllers/authorization/google'
module CalendarController

  def self.included(app)
    
    app.post '/create_calendar' do
      calendar_csv = params['csv_calendar'][:tempfile]
      calendar_name = params[:calendar_name]
      start_date = params[:calendar_start_date]
      auth_code = session[:auth_code]

      events = EventParser.new.parse_events(calendar_csv, start_date)

      begin
        cal = GoogleCalendarService.new(auth_code)
        calendar_id = cal.create_calendar(calendar_name)
        cal.create_events(events, calendar_id)
        flash[:notice] = "Calendar succesfully create"
      rescue Exception => e
        puts e
        session[:auth_code] = nil
        flash[:warning] = "Google grants expired. Please grant permissions one more time."
        redirect to("/calendar")
      end
      redirect to("/")
    end

    app.get '/calendar' do
      erb "/calendar/calendar".to_sym
    end

  end
end

