class InvitationRequest
  attr_accessor :email, :message, :answer
  
  def initialize(attrs = {})
    self.email = attrs[:email]
    self.message = attrs[:message]
    self.answer = attrs[:answer]
  end
  
  def valid?
    if email.blank? or message.blank? or answer != "15"
      return false
    else
      return true
    end
  end
end
