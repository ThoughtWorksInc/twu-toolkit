require 'models/events/event_parser'
require 'services/google_calendar_service'
require 'controllers/authorization/google'

module CalendarController

  def self.included(app)

    app.post '/create_calendar' do
      auth_code = session[:auth_code]

      begin
        cal = GoogleCalendarService.new(auth_code)
      rescue Exception => e
        puts e
        session[:auth_code] = nil
        flash[:warning] = "Google grants expired. Please grant permissions one more time."
        redirect to("/calendar")
      end

      events = EventParser.new.parse_events(params[:calendar_csv][:tempfile], params[:calendar_start_date])
      session[:calendar_name] = params[:calendar_name]
      session[:events] = events
      session[:cal] = cal

      redirect to('/create_calendar_hack')
    end

    app.get '/create_calendar_hack' do
      events = session[:events]
      calendar_name = session[:calendar_name]
      cal = session[:cal]

      begin
        calendar_id = cal.create_calendar(calendar_name)
        cal.create_events(events.shift(10), calendar_id)
      rescue Exception => e
        flash[:warning] = e.to_s
        redirect to("/calendar")
      end

      if events.empty? then
        flash[:notice] = "Calendar successfully created"
        session[:events] = nil
        session[:calendar_name] = nil
        redirect to("/")
      else
        session[:events] = events
        redirect to('/create_calendar_hack')
      end
    end

    app.get '/calendar' do
      erb "/calendar/calendar".to_sym
    end

  end
end

