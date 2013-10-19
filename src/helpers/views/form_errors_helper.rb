require 'sinatra/base'

module Sinatra
  module FormHelpers
    def field_error field, errors
      "<div class=\"field_errors\" >#{errors[field]}</div>" if !errors[field].nil?
    end
  end

  helpers FormHelpers
end

