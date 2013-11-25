module Authorization
  module Trello

    def self.included(app)
      app.get '/grant_trello_permissions' do
        byebug
        consumer = OAuth::Consumer.new(ENV['TRELLO_APPLICATION_KEY'], ENV['TRELLO_APPLICATION_SECRET'], {
          :site => "https://trello.com",
          :scheme => :header,
          :http_method => :post,
          :request_token_url => "https://trello.com/1/OAuthGetRequestToken",
          :access_token_url => "https://trello.com/1/OAuthGetAccessToken",
          :authorize_url => "https://trello.com/1/OAuthAuthorizeToken"
        })
        request_token = consumer.get_request_token(:oauth_callback => ENV['TRELLO_REDIRECT_URL'])
        session['trello_request_token'] = request_token
        redirect to(request_token.authorize_url + "&scope=read,write")
      end

      app.get '/register_trello_permissions' do
        request_token = session['trello_request_token']
        session['trello_auth'] = request_token.get_access_token(:oauth_verifier => params['oauth_verifier'])
        session['trello_request_token'] = nil
        redirect to('/trello')
      end

    end
  end

end

