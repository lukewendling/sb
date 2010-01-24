class ApplicationMailer < ActionMailer::Base
  self.template_root = File.join(Rails.root, 'app', 'mailers', 'views')
  
  def deliver_with_serialization!(mail = @mail)
    if mail
#      debugger
      SentMail.create!(:sender => mail.from.join(','), :recipients => mail.to.join(','), :subject => mail.subject, :serialized_mail => mail, :mailer_type => self.class.to_s)
    end
    deliver_without_serialization!(@mail)
  end
  alias_method_chain :deliver!, :serialization
end
