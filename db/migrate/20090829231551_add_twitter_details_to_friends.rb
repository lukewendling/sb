class AddTwitterDetailsToFriends < ActiveRecord::Migration
  def self.up
    change_table :friends do |t|
      t.string :twitter_screen_name
      t.string :twitter_profile_image_url
    end
  end

  def self.down
    change_table :friends do |t|
      t.remove :twitter_screen_name
      t.remove :twitter_profile_image_url
    end
  end
end
