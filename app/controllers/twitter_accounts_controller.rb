class TwitterAccountsController < ApplicationController
#  see rescue_from in application
  def update
    current_friend.remove_twitter!
    raise Twitter::Unauthorized, 'Send user to Twitter'
  end
  
#  see rescue_from in application
  def create
    raise Twitter::Unauthorized, 'Send user to Twitter'
  end
  
  def destroy
    current_friend.remove_twitter!
    flash[:notice] = "Your Twitter account has been removed"
    redirect_to challenges_url
  end
end
