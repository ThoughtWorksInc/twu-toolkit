class SessionTypes

  class Session
    attr_reader :type, :color_id, :is_default_for_trello

    def initialize type, color_id, is_default_for_trello=false
      @type = type
      @color_id = color_id
      @is_default_for_trello = is_default_for_trello if !is_default_for_trello.nil?
    end

    def to_json params
      {
        :type => @type
      }.to_json
    end
  end


  SESSIONS = [
    Session.new("TWU", '1'),
    Session.new("TW Basics", '2', true),
    Session.new("P3 Track", '3'),
    Session.new("Session", '4', true),
    Session.new("Business", '5'),
    Session.new("Internal", '6'),
    Session.new("PSIM", '7'),
    Session.new("Dev Dojo", '8'),
    Session.new("QA/BA Dojo", '9'),
    Session.new("BA Dojo", '10'), 
    Session.new("QA Dojo", '11'),
    Session.new("Dev/QA/BA Dojo", '12')
    Session.new("Dev/QA Dojo", '13')
  ]

  def self.find_by_session_types session_types_to_fetch
    SESSIONS.select { |e| session_types_to_fetch.include?(e.type) }
  end

  def self.by_type type
    SESSIONS.find { |e| e.type == type.to_s }
  end

end


