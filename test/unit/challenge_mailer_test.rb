require 'test_helper'

class ChallengeMailerTest < ActionMailer::TestCase
  tests ChallengeMailer 
  
  def setup
    @challenge = challenges(:linwood_to_luke)
  end
  
  def test_the_challenge
    # Send the email, then test that it got queued  
    SentMail.delete_all
    email = ChallengeMailer.deliver_the_challenge(@challenge).serialized_mail
    assert_equal 1, SentMail.count  
#    assert !ActionMailer::Base.deliveries.empty? 
    # Test the body of the sent email contains what we expect it to  
    assert_equal [@challenge.challenged.email], email.to 
    assert_equal "You've been challenged!", email.subject 
    assert_match /http:\/\/test.host\/challenge_accepted\/#{@challenge.hashed_id}/, email.body  
  end
  
  def test_update
    # Send the email, then test that it got queued  
    email = ChallengeMailer.deliver_update(@challenge).serialized_mail
#    assert !ActionMailer::Base.deliveries.empty? 
    # Test the body of the sent email contains what we expect it to  
    assert_equal @challenge.email_addresses, email.to 
    assert_equal "#{@challenge.challenged.name}'s challenge has been updated", email.subject 
    assert_match /||#{@challenge.hashed_id}||/, email.body
    assert_match /Reply above this line/, email.body
  end
end
