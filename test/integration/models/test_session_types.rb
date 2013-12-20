require 'test_helper'
require 'securerandom'

class TestSessionTypes < TwuToolkitIntegrationBase

  def test_find_by_session_types
    session_types = SessionTypes.find_by_session_types(["TWU", "Session"])
    assert_equal "TWU", session_types[0].name
    assert_equal "Session", session_types[1].name
    assert_equal 2, session_types.size
  end

  def test_by_type
    session_type = SessionTypes.by_type("TWU")
    assert_equal "TWU", session_type.name
  end

  def test_validate
    invalid_sessions = SessionTypes.validate(["TWU", "invalid"])
    assert_equal "invalid", invalid_sessions.first
  end

  def test_color_assignment_one_id_is_free
    SessionTypes.all.first.destroy!
    new_session_type = SessionTypes.create(name: 'new session', description: 'a new session', is_default_for_trello: true)

    assert_equal '1', new_session_type.color_id
  end

  def test_color_assignment_one_id_from_the_middle_is_free
    session_type = SessionTypes.all.shuffle.first
    free_color_id = session_type.color_id
    session_type.destroy!

    new_session_type = SessionTypes.create(name: 'new session', description: 'a new session', is_default_for_trello: true)

    assert_equal free_color_id, new_session_type.color_id
  end

  def test_color_assignment_no_id_is_free
    SessionTypes.all.last.destroy!
    next_color_id = (SessionTypes.all.last.color_id.to_i + 1).to_s

    new_session_type = SessionTypes.create(name: 'new session', description: 'a new session', is_default_for_trello: true)

    assert_equal next_color_id, new_session_type.color_id
  end

  def test_color_id_cant_be_bigger_than_thirteen
    while(SessionTypes.all.size < 13) do 
      SessionTypes.create(name: SecureRandom.hex, description: SecureRandom.hex, is_default_for_trello: true) 
    end

    new_session_type = SessionTypes.create(name: 'new session', description: 'a new session', is_default_for_trello: true)

    assert_equal '1', new_session_type.color_id
  end

end

 
