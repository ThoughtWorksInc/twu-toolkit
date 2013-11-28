class CreateSessionTypes < ActiveRecord::Migration
  def up
    create_table :session_types do |t|
      t.string :name
      t.text :description
      t.string :color_id
      t.boolean :is_default_for_trello
      t.timestamps
    end

    SessionTypes.create(name: "TWU", description: "", color_id: '1', is_default_for_trello: false).save
    SessionTypes.create(name: "TW Basics", description: "", color_id: '2', is_default_for_trello: true).save
    SessionTypes.create(name: "P3 Track", description: "", color_id: '3', is_default_for_trello: true).save
    SessionTypes.create(name: "Session", description: "", color_id: '4', is_default_for_trello: true).save
    SessionTypes.create(name: "Business", description: "", color_id: '5', is_default_for_trello: true).save
    SessionTypes.create(name: "Internal", description: "", color_id: '6', is_default_for_trello: false).save
    SessionTypes.create(name: "PSIM", description: "", color_id: '7', is_default_for_trello: false).save
    SessionTypes.create(name: "Dev Dojo", description: "", color_id: '8', is_default_for_trello: false).save
    SessionTypes.create(name: "QA/BA Dojo", description: "", color_id: '9', is_default_for_trello: false).save
    SessionTypes.create(name: "BA Dojo", description: "", color_id: '10', is_default_for_trello: false).save
    SessionTypes.create(name: "QA Dojo", description: "", color_id: '11', is_default_for_trello: false).save
    SessionTypes.create(name: "Dev/QA/BA Dojo", description: "", color_id: '12', is_default_for_trello: false).save
    SessionTypes.create(name: "Dev/QA Dojo", description: "", color_id: '13', is_default_for_trello: false).save
   
  end

  def down
    drop_table :session_types
  end
end
