require 'test_helper'

class ChallengeCommentMailerTest < ActionMailer::TestCase
  tests ChallengeCommentMailer 
  
  def setup
    @challenge = challenges(:linwood_to_luke)
    @challenge_comment = @challenge.comments.first
  end
  
  def test_comment
    # Send the email, then test that it got queued  
    email = ChallengeCommentMailer.deliver_comment(@challenge_comment)  
    assert !ActionMailer::Base.deliveries.empty? 
    # Test the body of the sent email contains what we expect it to  
#    assert_equal [@challenge.challenged.email], email.to 
    assert_equal (@challenge.friends - [@challenge_comment.friend]).map(&:email), email.to
    assert_equal "RE: #{@challenge.event.description.to_s[0..40]}", email.subject 
    assert_match /#{@challenge_comment.content}/, email.body  
  end
end
