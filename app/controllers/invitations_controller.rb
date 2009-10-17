class InvitationsController < ApplicationController
  before_filter :login_required, :except => [:i_wanna_play, :send_request]
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

  def i_wanna_play
    @invitation_request = InvitationRequest.new
  end
  
  def send_request
    @invitation_request = InvitationRequest.new(params[:invitation_request])
    if @invitation_request.valid?
      InvitationMailer.deliver_guest_request(@invitation_request, self)
      redirect_to login_url
      flash[:notice] = "Thank you. We will send an invitation shortly!"
    else
      flash[:notice] = "All fields are required"
      render :action => 'i_wanna_play'
    end
  end
end
