class AddHashedIdToFriend < ActiveRecord::Migration
  def self.up
    add_column :friends, :hashed_id, :string
    
    add_index :friends, :hashed_id, :unique => true
  end

  def self.down
    remove_column :friends, :hashed_id
  end
end
