require (Rails.root + 'app/models/friend')

class Friend
  def client
    @dummy ||= TwitterDumDum.new
  end
  
  class TwitterDumDum
    def update(msg)
      Rails.logger.debug "Tweeted: #{msg}"
    end
  end
end
