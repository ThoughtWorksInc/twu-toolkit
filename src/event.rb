class Event

  COLOR_ID = {
    :Session => '1',
    :Internal => '2',
    :PSIM => '3',
    "Dev Dojo".to_sym => '4',
    "QA/BA Dojo".to_sym => '5',
    "BA Dojo".to_sym => '6',
    "QA Dojo".to_sym => '7',
    :TWU => '8',
    "Case Study".to_sym => '9'
  }

  attr_reader :starting_time, :ending_time, :name, :session_link, :type

  def initialize(starting_time, ending_time, name, session_link, type) 
    @starting_time = starting_time
    @ending_time = ending_time
    @name = name
    @session_link = session_link
    @type = type.to_sym
  end

  def to_event_resource
    {
      'colorId' => COLOR_ID[type],
      'start' =>  { 'dateTime' => starting_time.rfc3339 },
      'end' => { 'dateTime' => ending_time.rfc3339 },
      'description' => session_link,
      'summary' => name
    }
  end

end

