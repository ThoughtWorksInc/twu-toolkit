class Event

  COLOR_ID = {
    :TWU => '1',
    "TWU Basics".to_sym => '2',
    "P3 Track".to_sym => '3',
    :Session => '4',
    :Business => '5',
    :Internal => '6',
    :PSIM => '7',
    "Dev Dojo".to_sym => '8',
    "QA/BA Dojo".to_sym => '9',
    "BA Dojo".to_sym => '10', 
    "QA Dojo".to_sym => '11'
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

