require 'sinatra'

require './src/event'
require './src/event_parser'
require './src/config'
require './src/google_calendar'
require './src/date_resolver'
require './src/event_factory'
require 'debugger'
require 'open-uri'

enable :sessions
set :session_secret, '&!@@#!jj'

get '/' do
  @oauth_url = GoogleCalendar::OATH_URL
  @message = params[:msg] if !params[:msg] == "" && !params[:msg].nil?
  erb :home
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
