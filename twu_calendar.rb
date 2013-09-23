require 'sinatra'

require './src/event'
require './src/event_parser'
require './src/config'
require './src/google_calendar'
require 'debugger'

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
  debugger
  begin
    cal = GoogleCalendar.new(session[:auth_code])
    cal.create_calendar(params[:calendar_name])
  rescue Exception => e
    puts e.inspect
    session[:auth_code] = nil
  ensure
    redirect to("/")
  end

end
