class MailSender
  def self.deliver_unsent
    SentMail.incomplete.each do |m| 
      ApplicationMailer.deliver_without_serialization(m.serialized_mail)
      m.toggle!(:complete)
    end
  end
end
