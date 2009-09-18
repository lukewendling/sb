class AddShowHiddenChallengesToFriends < ActiveRecord::Migration
  def self.up
    add_column :friends, :show_hidden_challenges, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :friends, :show_hidden_challenges
  end
end
