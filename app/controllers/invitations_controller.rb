class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end
  
  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_friend
    if @invitation.save
      if logged_in?
        InvitationMailer.deliver_invitation(@invitation, signup_url(@invitation.token))
        flash[:notice] = "Thank you, invitation sent."
        redirect_to challenges_url
      else
        flash[:notice] = "Thank you, we will notify when we are ready."
        redirect_to login_url
      end
    else
      render :action => 'new'
    end
  end

end
