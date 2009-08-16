class ChallengeCommentMailer < ApplicationMailer
  
  def comment(challenge_comment)
    subject    "RE: #{challenge_comment.challenge.event.description.to_s[0..40]}"
    chumps = challenge_comment.challenge.friends - [challenge_comment.friend]
    recipients chumps.map(&:email)
    from       AppConfig[:postman]
    sent_on    Time.now
    content_type "text/plain"

    body       :challenge_comment => challenge_comment
  end
end
