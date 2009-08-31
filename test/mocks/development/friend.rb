require (Rails.root + 'app/models/friend')

class Friend
  def client
    @dummy ||= TwitterDumDum.new
  end
  
  def twitter_user
    @dummy ||= TwitterDumDum.new
  end
  
#  mock Twitter client methods
  class TwitterDumDum
    def update(msg)
      Rails.logger.debug "Tweeted: #{msg}"
    end
    
    def profile_image_url
      'http://localhost:3000/images/rails.png'
    end
    
    def screen_name
      'twitterdumdum'
    end
  end
end
