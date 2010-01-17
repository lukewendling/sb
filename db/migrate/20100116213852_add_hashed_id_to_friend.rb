class AddHashedIdToFriend < ActiveRecord::Migration
  def self.up
    add_column :friends, :hashed_id, :string
    
    add_index :friends, :hashed_id, :unique => true
    
    say 'Updating friends ...'
    Friend.reset_column_information
    Friend.all.each do |f|
      f.hashed_id = Digest::SHA1.hexdigest([Time.now, rand].join)
      f.save!
    end
  end

  def self.down
    remove_column :friends, :hashed_id
  end
end
