require 'google/api_client'

class GoogleCalendarService

    def initialize(auth_code)
      @client = Google::APIClient.new

      @client.authorization.client_id = ENV['TWU_CALENDAR_OAUTH2_CLIENT_ID']
      @client.authorization.client_secret = ENV['TWU_CALENDAR_OAUTH2_CLIENT_SECRET']
      @client.authorization.scope = 'https://www.googleapis.com/auth/calendar'
      @client.authorization.redirect_uri = ENV['TWU_CALENDAR_OAUTH2_REDIRECT_URL']

      @client.authorization.code = auth_code
      @client.authorization.fetch_access_token!

      @calendar_api = @client.discovered_api('calendar', 'v3')
    end

    def create_calendar calendar_name
      result = nil
      ensure_authorized {
        result = @client.execute(:api_method => @calendar_api.calendars.insert,
                                 :body =>  { 'summary' => calendar_name }.to_json,
                                 :headers => {'Content-Type' => 'application/json'})
      }
      result.data.id
    end

    def create_events events, calendar_id
      events.each do |event|
        puts "Creating event #{event.to_event_resource.inspect}"
        ensure_authorized {
          result = @client.execute(:api_method => @calendar_api.events.insert,
                          :parameters => { 'calendarId' => calendar_id },
                          :body => event.to_event_resource.to_json,
                          :headers => {'Content-Type' => 'application/json'})
        }
      end
    end

    private

    def ensure_authorized
      begin
        yield
        return
      rescue Exception => e
        puts e
        @client.authorization.fetch_access_token!
      end
    end

end

