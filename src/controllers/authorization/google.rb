module Authorization
  module Google

    def self.included(app)
      app.get '/google_register_permissions' do
        session[:auth_code] = params[:code]
        puts session
        redirect to("/calendar")
      end

      app.get '/google_grant_permissions' do
        client = ::Google::APIClient.new
        client.authorization.client_id = ENV['TWU_CALENDAR_OAUTH2_CLIENT_ID']
        client.authorization.client_secret = ENV['TWU_CALENDAR_OAUTH2_CLIENT_SECRET']
        client.authorization.scope = 'https://www.googleapis.com/auth/calendar'
        client.authorization.redirect_uri = ENV['TWU_CALENDAR_OAUTH2_REDIRECT_URL']

        redirect client.authorization.authorization_uri.to_s, 303
      end

    end
  end
end

