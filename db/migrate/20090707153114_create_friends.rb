class CreateFriends < ActiveRecord::Migration
  def self.up
    create_table :friends do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :password_salt, :string
      t.string :atoken
      t.string :asecret
      t.timestamps
    end
    
    add_index :friends, :email, :unique => true
  end
  
  def self.down
    drop_table :friends
  end
end
