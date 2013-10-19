require 'sinatra'
require 'open-uri'
require 'oauth'
require 'oauth2'
require 'trello'
require 'rack-flash'

require 'helpers/views/form_errors_helper'

class TWUCalendar < Sinatra::Base
  
  use Rack::Session::Cookie, :secret => '123211'
  use Rack::Flash

  Dir["src/controllers/**/*.rb"].each { |f| require File.expand_path(f) }
  
  helpers Sinatra::FormHelpers

  include Authorization::Google
  include Authorization::Trello
  include CalendarController
  include TrelloController

  get '/' do
    erb :home
  end

end
