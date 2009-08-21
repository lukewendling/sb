class ChallengeMailer < ApplicationMailer
  

  def the_challenge(challenge)
    subject    "You've been challenged!"
    recipients challenge.challenged.email
    from       AppConfig[:mail_from]
    sent_on    Time.now
    content_type "text/plain"

    body       :challenge => challenge
  end

  def update(challenge)
    subject   "#{challenge.challenged.name}'s challenge has been updated"
    recipients challenge.email_addresses
    from      AppConfig[:reply_to]
    sent_on   Time.now
    content_type "text/plain"
    
    body      :challenge => challenge
  end
end
