require_dependency File.join(Rails.root, 'app', 'models', 'friend')

class Friend
  def client
    if can_tweet?
      @dummy ||= TwitterDumDum.new
    else
      NonTweeterer.new
    end
  end
  
  def twitter_user
    @dummy ||= TwitterDumDum.new
  end
  
  def twitter_profile_image_url
    '/images/rails.png'
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
