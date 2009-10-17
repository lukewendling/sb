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
    
  def guest_request(invitation_request, controller)
    subject    "New invitation request"
    recipients "debug@shouldbet.com"
    from       AppConfig[:mail_from]
    body       :invitation_request => invitation_request, 
               :request => controller.request,
               :host => (controller.request.env["HTTP_X_FORWARDED_HOST"] || controller.request.env["HTTP_HOST"])
    content_type  'text/plain'
  end
end
