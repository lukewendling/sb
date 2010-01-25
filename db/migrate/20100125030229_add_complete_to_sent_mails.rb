class AddCompleteToSentMails < ActiveRecord::Migration
  def self.up
    add_column :sent_mails, :complete, :boolean, :default => false, :nil => false
  end

  def self.down
    remove_column :sent_mails, :complete
  end
end
