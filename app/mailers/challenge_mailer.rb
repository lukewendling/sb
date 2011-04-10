class ChallengeMailer < ApplicationMailer
  
  def the_challenge(challenge)
    subject    "You've been challenged!"
    recipients challenge.challenged.email
    from       AppConfig[:mail_from]
    sent_on    Time.now
    content_type "text/plain"

    shorty = ShortUrl.new(AppConfig[:bitly_username], AppConfig[:bitly_key])
    long_url = accept_challenge_url(challenge.hashed_id)
    short_url = shorty.shorten(long_url).short_url rescue long_url
    body       :challenge => challenge, :short_url => short_url
  end

  def update(challenge)
    subject   "#{challenge.challenged.name}'s challenge has been updated"
    recipients challenge.email_addresses
    from      AppConfig[:reply_to]
    sent_on   Time.now
    content_type "text/plain"
    
    shorty = ShortUrl.new(AppConfig[:bitly_username], AppConfig[:bitly_key])
    long_url = challenge_url(challenge)
    short_url = shorty.shorten(long_url).short_url rescue long_url
    body      :challenge => challenge, :short_url => short_url
  end
end
