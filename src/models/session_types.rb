require 'sinatra/activerecord'

class SessionTypes < ActiveRecord::Base

  def self.find_by_session_types session_types_to_fetch
    all.select { |e| session_types_to_fetch.include?(e.name) }
  end

  def self.by_type type
    find { |e| e.name == type.to_s }
  end

  def self.valid_sessions
    @@valid_sessions ||= all.collect { |e| e.name }
  end

  def self.validate user_input_session_types
    invalid_sessions = []
    user_input_session_types.each do |s|
       invalid_sessions.push(s) if !valid_sessions.include?(s) 
    end
    invalid_sessions
  end

end


