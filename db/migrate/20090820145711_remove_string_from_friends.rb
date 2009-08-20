class RemoveStringFromFriends < ActiveRecord::Migration
  def self.up
#    remove weirdo column
    remove_column :friends, :string
  end

  def self.down
  end
end
