class AddInvitationToUsers < ActiveRecord::Migration
  def self.up
    add_column :friends, :invitation_id, :integer
    add_column :friends, :invitation_limit, :integer
  end

  def self.down
    remove_column :friends, :invitation_limit
    remove_column :friends, :invitation_id
  end
end
