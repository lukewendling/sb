class InvitationMailer < ApplicationMailer
  
  def invitation(invitation, signup_url)
    subject    "Invitation to join #{AppConfig[:domain]}"
    recipients invitation.recipient_email
    from       AppConfig[:mail_from]
    body       :invitation => invitation, :signup_url => signup_url
    content_type  'text/html'
    invitation.update_attribute(:sent_at, Time.now)
  end
  
  def invite_complete(invitation)
    subject    "#{invitation.recipient.name} has joined #{AppConfig[:domain]}!"
    recipients invitation.sender.email
    from       AppConfig[:mail_from]
    body       :invitation => invitation
    content_type  'text/html'
  end
end
