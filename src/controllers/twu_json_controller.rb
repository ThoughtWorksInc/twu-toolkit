require 'models/session_types'

module TwuJsonController
  A_FRIDAY = '2013-11-22'

  def self.included(app)

    app.get '/twu.json' do 
      erb "/twu.json/twu-json".to_sym
    end

    app.post '/twu.json' do
      calendar_csv = params['csv_calendar'][:tempfile]

      events = EventParser.new.parse_events(calendar_csv, A_FRIDAY)
      JSON.pretty_generate(
        { 
          :session_types => SessionTypes::SESSIONS.to_json,
          :events => events.to_json
      })
    end
  end
end
