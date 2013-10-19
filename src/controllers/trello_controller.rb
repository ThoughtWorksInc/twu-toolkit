require 'models/events/event_parser'
require 'services/twu_trello_service'
require 'controllers/authorization/trello'

module TrelloController
  def self.included(app)

    app.get '/trello' do
      erb "/trello/trello".to_sym
    end

    app.post '/create_trello' do
      t = session['trello_auth']
      calendar_csv = params['csv_calendar'][:tempfile]
      trello_board_name = params[:trello_board_name]
      start_date = params[:calendar_start_date]

      Trello.configure do |config|
        config.consumer_key = t.consumer.key
        config.consumer_secret = t.consumer.secret
        config.oauth_token = t.token
        config.oauth_token_secret = t.secret
      end
      events = EventParser.new.parse_events(calendar_csv, start_date)
      TWUTrelloService.create(events, trello_board_name)
      flash[:notice] = "Calendar succesfully create"
      redirect to("/")
    end

  end
end

