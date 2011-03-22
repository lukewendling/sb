class ChallengeComment < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :friend
  
  validates_presence_of :challenge, :friend, :content
  
  named_scope :date_sorted, :order => :updated_at
  
  def self.per_page
    Rails.env == 'development' ? 3 : 10
  end
  
  validates_each :content do |record, attr, value|
    record.errors.add attr, 'contains invalid content.' if value && value.match( INVALID_CONTENT_PATTERN )
  end
  
  def after_create
    super
    ChallengeCommentMailer.deliver_comment(self)
    recipient = (challenge.friends - [friend]).first
    friend.client.update("(#{AppConfig[:domain]}) to #{recipient.twitter_screen_name}: \"#{content}\""[0,140])
#    recipient.client.update("#{AppConfig[:domain]} comment from #{friend.twitter_screen_name}: \"#{content}\"")
  end
end
