require 'sinatra'

require 'event'
require 'event_parser'
require 'google_calendar'
require 'date_resolver'
require 'event_factory'
require 'string_ext'
require 'twu_trello'
require 'open-uri'
require 'oauth'
require 'oauth2'
require 'trello'
require 'rack-flash'
require 'authorization/trello'
require 'authorization/google'

class TWUCalendar < Sinatra::Base
  
  include Authorization::Trello
  include Authorization::Google

  use Rack::Session::Cookie
  use Rack::Flash

  get '/' do
    erb :home
  end

  post '/create_trello' do
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
    TWUTrello.create(events, trello_board_name)
    flash[:notice] = "Calendar succesfully create"
    redirect to("/")
  end

  post '/create_calendar' do
    calendar_csv = params['csv_calendar'][:tempfile]
    calendar_name = params[:calendar_name]
    start_date = params[:calendar_start_date]
    auth_code = session[:auth_code]

    events = EventParser.new.parse_events(calendar_csv, start_date)

    begin
      cal = GoogleCalendar.new(auth_code)
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

  get '/calendar' do
    erb "/calendar/calendar".to_sym
  end

  get '/trello' do
    erb "/trello/trello".to_sym
  end
  
end
