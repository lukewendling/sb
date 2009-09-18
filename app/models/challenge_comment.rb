class ChallengeComment < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :friend
  
  validates_presence_of :challenge, :friend, :content
  
  def self.per_page
    Rails.env == 'development' ? 3 : 10
  end
  
  def after_create
    super
    ChallengeCommentMailer.deliver_comment(self)
    recipient = (challenge.friends - [friend]).first
    friend.client.update("Commented on #{AppConfig[:domain]} to #{recipient.twitter_screen_name}: \"#{content}\"")
#    recipient.client.update("#{AppConfig[:domain]} comment from #{friend.twitter_screen_name}: \"#{content}\"")
  end
end
