Dir['src/**/*.rb'].each { |f| require File.basename(f) }

require 'debugger'
require 'test/unit'


