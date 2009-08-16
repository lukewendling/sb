class CreateChallenges < ActiveRecord::Migration
  def self.up
    create_table :challenges do |t|
      t.integer :challenger_id, :null => false
      t.integer :challenged_id, :null => false
      t.integer :event_id, :null => false
      t.text    :prediction, :null => false
      t.integer :winner_id
      t.text    :result
      t.string  :hashed_id, :null => false
      t.boolean :accepted, :default => false, :null => false
      t.boolean :contested, :default => false, :null => false
      t.timestamps
    end
    
    add_index :challenges, :challenger_id
    add_index :challenges, :challenged_id
    add_index :challenges, :event_id
    add_index :challenges, :hashed_id, :unique => true
  end
  
  def self.down
    drop_table :challenges
  end
end
