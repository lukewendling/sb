class ChallengeComment < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :friend
  
  validates_presence_of :challenge, :friend, :content
  
  def self.per_page
    Rails.env == 'development' ? 3 : 15
  end
  
  def after_create
    super
    ChallengeCommentMailer.deliver_comment(self)
    recipient = (challenge.friends - [friend]).first
    recipient.client.update("Commented on #{AppConfig[:domain]} to #{recipient.username}: \"#{content}\"")
  end
end
