require 'test_helper'

class ChallengeCommentTest < ActiveSupport::TestCase
  should_belong_to :challenge, :friend
  should_validate_presence_of :challenge, :friend, :content
  
  def setup
    @challenge = challenges(:linwood_to_luke)
    @comment = @challenge.comments.first
  end
  
  def test_should_tweet_when_created
#    TODO:
    comment = @challenge.comments.build
    comment.friend = @challenge.friends.first
    comment.content = 'sucker!'
    assert_difference "SentMail.count" do
      comment.save!
    end
  end
end
