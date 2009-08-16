class SessionsController < ApplicationController
  skip_before_filter :login_required
  
  def new
  end
  
  def create
    friend = Friend.authenticate(params[:login], params[:password])
    if friend
      session[:friend_id] = friend.id
      flash[:notice] = "Logged in successfully."
      original_uri = session[:original_uri]
      session[:original_uri] = nil if original_uri
      redirect_to original_uri || root_url
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
