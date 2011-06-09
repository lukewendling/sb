require 'lockfile'
require 'net/imap'

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
    
  def self.fetch
    Lockfile('lock' , :retries => 0) do
      imap = Net::IMAP.new(AppConfig[:imap_server], AppConfig[:imap_port], true)
      imap.login(AppConfig[:imap_username], AppConfig[:imap_pwd])
      imap.select('INBOX')
      imap.search(["NOT", "DELETED"]).each do |message_id|
        email = imap.fetch(message_id, 'RFC822' )[0].attr['RFC822']
        parsed_mail = TMail::Mail.parse(email)
        unless parsed_mail.to.nil? # Spam
          begin
            self.receive(parsed_mail)
          rescue DisorderlyMailException
            imap.copy message_id, 'Disorderly'
          rescue
            imap.copy message_id, 'Failed'
          end
        end
        imap.store(message_id, "+FLAGS" , [:Deleted]) unless Rails.env == 'development'
      end

      imap.expunge
      imap.logout
      imap.disconnect
    end
  end
  
  class DisorderlyMailException < Exception;  end
end
