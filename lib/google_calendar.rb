require 'google/api_client'

class GoogleCalendar
  OATH_URL = "https://accounts.google.com/o/oauth2/auth?"

  def initialize
    @client = Google::APIClient.new
    @client.authorization.client_id = ENV['TWU_CALENDAR_CLIENT_ID']
    @client.authorization.client_secret = ENV['TWU_CALENDAR_CLIENT_ID']
    @client.authorization.redirect_uri = ENV['TWU_CALENDAR_REDIRECT_URI']
    @client.authorization.code = ENV['TWU_CALENDAR_CODE']
    
    @auth = @client.authorization.dup
    @auth.fetch_access_token!

    @calendar_api = @client.discovered_api('calendar', 'v3')
  end

  def create_calendar calendar_name
    @client.execute(:api_method => @calendar_api.calendars.insert,
                    :parameters =>  { 'summary' => calendar_name },
                    :authorization => @auth)
  end

  def create_event event, calendar_name
  end
  
end

