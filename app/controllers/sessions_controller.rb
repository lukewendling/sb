class SessionsController < ApplicationController
  skip_before_filter :login_required
  
  def new
    redirect_to challenges_path if logged_in?
  end
  
  def create
    friend = Friend.authenticate(params[:login], params[:password])
    if friend
      session[:friend_id] = friend.id
      flash[:notice] = "You are logged in!"
      original_uri = session[:original_uri]
      session[:original_uri] = nil if original_uri
      redirect_to original_uri || challenges_url
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end
  
  def destroy
    session[:friend_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end
end
