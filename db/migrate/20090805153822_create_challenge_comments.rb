class CreateChallengeComments < ActiveRecord::Migration
  def self.up
    create_table :challenge_comments do |t|
      t.integer :friend_id
      t.integer :challenge_id
      t.text :content
      t.timestamps
    end
    
    add_index :challenge_comments, :friend_id
    add_index :challenge_comments, :challenge_id
  end
  
  def self.down
    drop_table :challenge_comments
  end
end
