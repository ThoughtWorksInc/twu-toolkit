require 'models/events/event_parser'
require 'services/google_calendar_service'
require 'controllers/authorization/google'

module CalendarController

  def self.included(app)

    app.post '/create_calendar' do
      auth_code = session[:auth_code]

      events = EventParser.new.parse_events(params[:calendar_csv][:tempfile], params[:calendar_start_date])

      user_input_sessions_types = events.collect { |e| e.type }.uniq.map(&:to_s)
      @errors = SessionTypes.validate(user_input_sessions_types)
      if !@errors.empty? then
        flash[:warning] = 'Oops, there were errors'
        erb ""
      else

        begin
          cal = GoogleCalendarService.new(auth_code)
        rescue Exception => e
          puts e
          session[:auth_code] = nil
          flash[:warning] = "Google grants expired. Please grant permissions one more time."
          redirect to("/calendar")
        end

        begin
          calendar_id = cal.create_calendar(params[:calendar_name])
          cal.create_events(events, calendar_id)
          flash[:notice] = "Calendar successfully created"
        rescue Exception => e
          flash[:warning] = e.to_s
          redirect to("/calendar")
        end
        redirect to('/')

      end
    end

    app.get '/calendar' do
      erb "/calendar/calendar".to_sym
    end

  end
end

