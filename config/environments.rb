require 'sinatra/activerecord'
require 'sinatra'
require './src/models/session_types'

configure :test do
  db = URI.parse(ENV['DATABASE_URL_TEST'])
  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end

configure :development, :production do
  db = URI.parse(ENV['HEROKU_POSTGRESQL_BRONZE_URL'] || ENV['DATABASE_URL'])
  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end
