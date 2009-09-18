class CreateChallengePreferences < ActiveRecord::Migration
  def self.up
    create_table :challenge_preferences do |t|
      t.belongs_to :challenge
      t.belongs_to :friend
      t.boolean :hidden, :null => false, :default => false
      t.boolean :flagged, :null => false, :default => false

      t.timestamps
    end
    
    add_index :challenge_preferences, :challenge_id
    add_index :challenge_preferences, :friend_id
    
    if Rails.env != 'development'
      Challenge.all.each do |c|
        c.friends.each{ |f| c.preferences.create(:friend => f) }
      end
    end
  end

  def self.down
    drop_table :challenge_preferences
  end
end
