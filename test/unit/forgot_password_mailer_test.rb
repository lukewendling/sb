require 'test_helper'

class ForgotPasswordMailerTest < ActionMailer::TestCase
  
  def test_reset_notification
    friend = friends(:linwood)
    email = ForgotPasswordMailer.deliver_reset_notification(friend)  
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal [friend.email], email.to
  end 
end
