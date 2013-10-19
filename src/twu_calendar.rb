require 'sinatra'
require 'open-uri'
require 'oauth'
require 'oauth2'
require 'trello'
require 'rack-flash'

class TWUCalendar < Sinatra::Base
  
  use Rack::Session::Cookie, :secret => '123211'
  use Rack::Flash

  set :root, File.join(File.dirname(__FILE__), "..")
  set :views, File.join(root, "views") 

  Dir["src/controllers/**/*.rb"].each { |f| require File.expand_path(f) }
  
  include Authorization::Google
  include Authorization::Trello
  include CalendarController
  include TrelloController

  get '/' do
    erb :home
  end

end
