class TwitterAccountsController < ApplicationController
  def update
    current_friend.remove_twitter!
    redirect_to root_path
  end
end
