require 'sinatra/activerecord'

class SessionTypes < ActiveRecord::Base
  MAX_NUMBER_COLOR_ID = 13
  POSSIBLE_COLOR_ID_RANGE = (1..MAX_NUMBER_COLOR_ID).to_a

  before_create :assing_color_id

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

  def assing_color_id
    return if !self.color_id.nil?

    real_color_id_range = SessionTypes.all.collect { |e| e.color_id }.map(&:to_i).sort.to_a

    free_color_ids = POSSIBLE_COLOR_ID_RANGE - real_color_id_range

    self.color_id = free_color_ids.empty? ? "1" : free_color_ids.first.to_s
  end

end


