require 'test_helper'

class InvitationMailerTest < ActionMailer::TestCase
  tests InvitationMailer 
  
  def setup
    @invitation = invitations(:luke_to_linwood)
  end
  
  def test_invitation
    # Send the email, then test that it got queued  
    email = InvitationMailer.deliver_invitation(@invitation, 'http://test.host/signup_url').serialized_mail
#    assert !ActionMailer::Base.deliveries.empty? 
    # Test the body of the sent email contains what we expect it to  
    assert_equal [@invitation.recipient_email], email.to 
    assert_equal "Invitation to join #{AppConfig[:domain]}", email.subject 
    assert_match /http:\/\/test.host\/signup_url/, email.body  
    assert_match /#{@invitation.sender.name} invited you to join/, email.body
  end
  
  def test_invite_complete
    # Send the email, then test that it got queued  
    email = InvitationMailer.deliver_invite_complete(@invitation).serialized_mail
#    assert !ActionMailer::Base.deliveries.empty? 
    # Test the body of the sent email contains what we expect it to  
    assert_equal [@invitation.sender.email], email.to 
    assert_equal "#{@invitation.recipient.name} has joined #{AppConfig[:domain]}!", email.subject 
    assert_match /#{@invitation.recipient.name} \(#{@invitation.recipient.email}\) has signed up!/, email.body  
  end
end
