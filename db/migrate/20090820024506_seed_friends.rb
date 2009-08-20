class SeedFriends < ActiveRecord::Migration
  def self.up
    friend = Friend.new
    friend.username = 'lukewendling'
    friend.email = 'landonlw@yahoo.com'
    friend.password = '123456'
    friend.name = 'Luke W'
    friend.invitation_id = 0 # dummy
    friend.save!
  end

  def self.down
    Friend.delete_all
  end
end
