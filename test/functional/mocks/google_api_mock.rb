class AuthMock
  def method_missing(name, *args, &block)
  end

  def authorization_uri
    "/google_register_permissions?code=1"
  end

end

class CalendarApiMock
  def calendars
    calendars_api = Object.new
    calendars_api.define_singleton_method(:insert) { "insert_calendar" }
    calendars_api
  end

  def events
    events_api = Object.new
    events_api.define_singleton_method(:insert) { "insert_event" }
    events_api
  end

end

class GoogleApiMock
  def execute(*args)
    if args[0][:api_method] == "insert_calendar" then
      result = Object.new
      result.define_singleton_method(:data) do
        data_obj = Object.new
        data_obj.define_singleton_method(:id) { "calendar_id" }
        data_obj
      end
      return result
    end

    if args[0][:api_method] == "insert_event" then
      return "event_inserted"
    end
  end

  def discovered_api(name, version)
    CalendarApiMock.new
  end

  def authorization
    AuthMock.new
  end

end

Google::APIClient = GoogleApiMock
