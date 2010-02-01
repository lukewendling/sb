class Invitation < ActiveRecord::Base
  belongs_to :sender, :class_name => 'Friend'
  has_one :recipient, :class_name => 'Friend'

  validates_presence_of :recipient_email
  validates_format_of :recipient_email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validate :recipient_is_already_registered
  validate :sender_has_invitations, :if => :sender

  before_create :generate_token
  before_create :decrement_sender_count, :if => :sender

  private

    def recipient_is_already_registered
      errors.add :recipient_email, 'is already registered' if Friend.find_by_email(recipient_email.downcase)
    end

    def sender_has_invitations
      unless sender.invitation_limit > 0
        errors.add_to_base 'You have reached your limit of invitations to send.'
      end
    end

    def generate_token
      self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end

    def decrement_sender_count
      sender.decrement! :invitation_limit
    end

end
