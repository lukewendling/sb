require (Rails.root + 'app/models/friend')

class Friend
  def client
    self
  end
  
  def update(msg)
    logger.debug "Tweeted: #{msg}"
  end
end
