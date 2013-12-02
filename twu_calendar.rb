require 'sinatra'
require 'sinatra/activerecord'

require 'open-uri'
require 'oauth'
require 'oauth2'
require 'trello'
require 'rack/flash'
require 'json'

require 'models/session_types'

class TWUCalendar < Sinatra::Base

  use Rack::Session::Cookie, :secret => '123211'
  use Rack::Flash

  set :logging, true

  Dir["src/controllers/**/*.rb"].each { |f| require File.expand_path(f) }
  
  include Authorization::Google
  include Authorization::Trello
  include CalendarController
  include TrelloController
  include TwuJsonController
  include VisualisationsController
  include SessionTypesController

  get '/' do
    erb :home
  end

end
