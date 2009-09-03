class ChallengeCommentMailer < ApplicationMailer
  
  def comment(challenge_comment)
    subject    "RE: #{challenge_comment.challenge.event.description.to_s[0..40]}"
    recipients challenge_comment.challenge.email_addresses
    from       AppConfig[:reply_to]
    sent_on    Time.now
    content_type "text/plain"

    body       :challenge_comment => challenge_comment
  end
end
