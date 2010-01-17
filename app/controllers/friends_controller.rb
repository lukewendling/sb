class FriendsController < ApplicationController
  
  skip_before_filter :login_required, :only => [:new, :create]
  before_filter :authorize, :only => [:edit, :update]
  
  def new
    @friend = Friend.new(:invitation_token => params[:invitation_token])
    @friend.email = @friend.invitation.recipient_email if @friend.invitation
  end

  def create
    @friend = Friend.new(params[:friend])
    if @friend.save
      session[:friend_id] = @friend.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @friend ||= Friend.find_by_hashed_id(params[:id])
  end
  
  def update
    @friend ||= Friend.find_by_hashed_id(params[:id])
    if @friend.update_attributes(params[:friend])
      flash[:notice] = "Account updated!"
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
  
  private
    def authorize
      @friend = Friend.find_by_hashed_id(params[:id])
      render(:text => 'Unauthorized', :status => 401) unless @friend == current_friend
    end
end
