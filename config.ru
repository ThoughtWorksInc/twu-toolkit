$:.unshift('src')

require File.expand_path('twu_calendar')

require 'rack-timeout'
use Rack::Timeout           # Call as early as possible so rack-timeout runs before other middleware.
Rack::Timeout.timeout = 180  # This line is optional. If omitted, timeout defaults to 15 seconds.

run TWUCalendar
