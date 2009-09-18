class SeedFriends < ActiveRecord::Migration
  def self.up
    if Rails.env != 'development'
      friend = Friend.new
      friend.username = 'lukewendling'
      friend.email = 'landonlw@yahoo.com'
      friend.password = '123456'
      friend.name = 'Luke W'
      friend.invitation_id = 0 # dummy
      friend.save!
    end
  end

  def self.down
    Friend.delete_all if Rails.env != 'development'
  end
end
