class ApplicationMailer < ActionMailer::Base
  self.template_root = File.join(Rails.root, 'app', 'mailers', 'views')
end
