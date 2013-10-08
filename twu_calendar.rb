require 'sinatra'

require './src/event'
require './src/event_parser'
require './src/config'
require './src/google_calendar'
require './src/date_resolver'
require './src/event_factory'
require './src/string_ext'
require './src/twu_trello'
require 'debugger'
require 'open-uri'
require 'oauth'
require 'trello'

class TWUCalendar < Sinatra::Base
  
  use Rack::Session::Cookie

  get '/' do
    @oauth_url = GoogleCalendar::OATH_URL
    @message = params[:msg] if !params[:msg] == "" && !params[:msg].nil?
    erb :home
  end

  get '/grant_trello_permissions' do
    consumer = OAuth::Consumer.new(ENV['TRELLO_APPLICATION_KEY'], ENV['TRELLO_APPLICATION_SECRET'], {
      :site => "https://trello.com",
      :scheme => :header,
      :http_method => :post,
      :request_token_url => "https://trello.com/1/OAuthGetRequestToken",
      :access_token_url => "https://trello.com/1/OAuthGetAccessToken",
      :authorize_url => "https://trello.com/1/OAuthAuthorizeToken"
    })
    request_token = consumer.get_request_token(:oauth_callback => ENV['TRELLO_REDIRECT_URL'])
    session['trello_request_token'] = request_token
    redirect to(request_token.authorize_url + "&scope=read,write")
  end

  get '/register_trello_permissions' do
    request_token = session['trello_request_token']
    session['trello_auth'] = request_token.get_access_token(:oauth_verifier => params['oauth_verifier'])
    session['trello_request_token'] = nil
    redirect to('/trello')
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
  end

  get '/calendar' do
    erb "/calendar/calendar".to_sym
  end

  get '/trello' do
    erb "/trello/trello".to_sym
  end

  post '/grant_permission' do
    session[:auth_code] = params[:code]
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
      message = 'Calendar created succesfully'
    rescue Exception => e
      puts e
      session[:auth_code] = nil
      message = 'Autorization failed, please grant authorization one more time'
    ensure
      redirect to("/?msg=#{URI.encode(message)}")
    end
  end

end
