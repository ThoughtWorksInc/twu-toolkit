#!/usr/bin/env ruby

require_relative 'lib/twu_calendar'

events = parse_events
events.each { |e| puts e.calendar_name }
