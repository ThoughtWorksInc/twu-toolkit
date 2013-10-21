require 'test_helper'

class BaseTest < Test::Unit::TestCase
  include Capybara::DSL

  def setup
    Capybara.app = TWUCalendar.new
  end

  def teardown
    Capybara.reset_sessions!
  end
end
