class InvitationMailer < ApplicationMailer
  
  def invitation(invitation, signup_url)
    subject    "Invitation to join #{AppConfig[:domain]}"
    recipients invitation.recipient_email
    from       AppConfig[:mail_from]
    body       :invitation => invitation, :signup_url => signup_url
    content_type  'text/html'
    invitation.update_attribute(:sent_at, Time.now)
  end
end
