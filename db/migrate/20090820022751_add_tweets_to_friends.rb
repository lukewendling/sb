class AddTweetsToFriends < ActiveRecord::Migration
  def self.up
    add_column :friends, :tweets, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :friends, :tweets
  end
end
