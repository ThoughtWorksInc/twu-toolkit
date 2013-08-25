require './config'
require 'csv'

FILE = 'calendar-base.csv'
OPTIONS = { :headers => true }

def create_event_name(month, day, time, name, presenters) 
  event_name = "#{name} on #{month} #{day} at #{time}"
  event_name += " - #{presenters}" if !presenters.nil?
  event_name
end

CSV.foreach(FILE,  OPTIONS) do |row|
  event_name = create_event_name(row[0], row[1], row[2], row[3], row[4])
  command = "google calendar add --cal #{CALENDAR} \"#{event_name}\""
  
  5.times do
      system(command)
      if $?.exitstatus != 0 then
        sleep 5
      else
        break
      end
  end
end

