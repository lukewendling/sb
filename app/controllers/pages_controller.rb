class PagesController < ApplicationController
  def index
    if current_friend.can_tweet?
      redirect_to challenges_path
    else
      raise Twitter::Unauthorized, 'No tweeting for you!'
    end
  end
end
