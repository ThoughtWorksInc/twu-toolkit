$:.unshift('src')

require File.expand_path('twu_calendar')

require 'rack-timeout'
use Rack::Timeout           
Rack::Timeout.timeout = 300  # creating the calendars takes time and we don't want heroku to fail

run TWUCalendar
