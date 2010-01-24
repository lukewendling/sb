class ForgotPasswordMailer < ApplicationMailer
  
  def reset_notification(friend)
    subject   "Password reset"
    recipients friend.email
    from      AppConfig[:mail_from]
    sent_on   Time.now
    content_type "text/plain"
    
    body      :friend => friend
  end
end
