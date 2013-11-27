require 'json'
require 'models/session_types'

module VisualisationsController
  A_FRIDAY = '2013-11-22'

  def self.included(app)

    app.get '/visualisations' do 
      erb "/visualisations/create_visualisations".to_sym
    end

    app.post '/visualisations' do
      calendar_csv = params['csv_calendar'][:tempfile]

      events = EventParser.new.parse_events(calendar_csv, A_FRIDAY)
      @json = JSON.pretty_generate(
        { 
          :session_types => SessionTypes::SESSIONS.to_json,
          :events => events.to_json
      })
      erb "/visualisations/show_visualisations".to_sym
    end
  end
end
