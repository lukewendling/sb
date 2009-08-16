class MailFetcher
  def self.receive(mail)
    c_id = mail.body.match(/\|\|(\S+)\|\|/)
    raise DisorderlyMailException, 'Challenger ID is missing' unless c_id
    hashed_id = c_id.captures.first
    challenge = Challenge.find_by_hashed_id(hashed_id)
    raise DisorderlyMailException, 'Unknown challenge' unless challenge
    sender = mail.from.first.downcase
    raise DisorderlyMailException, 'Email sender does not match any of challenge email addresses' unless challenge.email_addresses.include?(sender)
    friend = Friend.find_by_email(sender)
    reply = mail.body.match(/^(.+)Reply\sabove\sthis\sline/m)
    raise DisorderlyMailException, 'Reply delimiter is missing' unless reply
    message = reply.captures.first
    comment = challenge.comments.create(:friend => friend, :content => message)
  end
  
  class DisorderlyMailException < Exception;  end
end
