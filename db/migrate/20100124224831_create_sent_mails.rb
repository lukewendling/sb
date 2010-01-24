class CreateSentMails < ActiveRecord::Migration
  def self.up
    create_table :sent_mails do |t|
      t.string :sender
      t.string :recipients
      t.string :subject
      t.string :mailer_type
      t.text :serialized_mail

      t.timestamps
    end
  end

  def self.down
    drop_table :sent_mails
  end
end
