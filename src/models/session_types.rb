require 'sinatra/activerecord'

class SessionTypes < ActiveRecord::Base
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
    possible_color_id_range = (1..SessionTypes.all.sort_by{ |e| e.color_id.to_i }.last.color_id.to_i).to_a

    self.color_id = real_color_id_range.size == possible_color_id_range.size ? (real_color_id_range.last + 1).to_s : (possible_color_id_range - real_color_id_range).first.to_s
  end

end


