require 'google/api_client'

class GoogleCalendar

  TWU_CALENDAR_CLIENT_ID =  ENV['TWU_CALENDAR_CLIENT_ID']
  TWU_CALENDAR_CLIENT_SECRET = ENV['TWU_CALENDAR_CLIENT_SECRET']
  TWU_CALENDAR_REDIRECT_URI = ENV['TWU_CALENDAR_REDIRECT_URI']
  TWU_CALENDAR_SCOPE = "https://www.googleapis.com/auth/calendar"

  OATH_URL = "https://accounts.google.com/o/oauth2/auth?" +
    "redirect_uri=#{TWU_CALENDAR_REDIRECT_URI}&" + 
    "client_id=#{TWU_CALENDAR_CLIENT_ID}&" + 
    "scope=#{TWU_CALENDAR_SCOPE}&" + 
    "response_type=code&approval_prompt=force" 

  def initialize(auth_code)
    @client = Google::APIClient.new
    @client.authorization.client_id = TWU_CALENDAR_CLIENT_ID
    @client.authorization.client_secret = TWU_CALENDAR_CLIENT_SECRET
    @client.authorization.redirect_uri = TWU_CALENDAR_REDIRECT_URI
    @client.authorization.scope = TWU_CALENDAR_SCOPE
    @client.authorization.code = auth_code
    @client.authorization.fetch_access_token!
    
    @calendar_api = @client.discovered_api('calendar', 'v3')
  end

  def create_calendar calendar_name
    result = @client.execute(:api_method => @calendar_api.calendars.insert,
                    :body =>  { 'summary' => calendar_name }.to_json,
                    :headers => {'Content-Type' => 'application/json'})
    puts result.data.inspect
  end

  def create_event event, calendar_name
  end
  
end

