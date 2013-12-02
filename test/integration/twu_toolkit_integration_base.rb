require './config/environments'
require 'rake/testtask'
require 'sinatra/activerecord/rake'

class TwuToolkitIntegrationBase < Test::Unit::TestCase
  def setup
    Sinatra::ActiveRecordTasks.rollback
    Sinatra::ActiveRecordTasks.migrate
  end
end

