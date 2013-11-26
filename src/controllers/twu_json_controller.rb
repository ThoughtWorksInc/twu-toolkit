require 'json'

module TwuJsonController
  A_MONDAY = '2013-11-25'

  def self.included(app)

    app.get '/twu.json' do 
      erb "/twu.json/twu-json".to_sym
    end

    app.post '/twu.json' do
      calendar_csv = params['csv_calendar'][:tempfile]

      events = EventParser.new.parse_events(calendar_csv, A_MONDAY)
      JSON.pretty_generate(events)
    end
  end
end
