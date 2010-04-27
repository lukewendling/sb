class ChallengePreferencesController < ApplicationController
  before_filter :instantiate_challenge
  authorize_resource
#  before_filter :authorize
  
#  def show
#    @challenge_preference ||= @challenge.preferences.find(params[:id])
#  end
#  
  def edit
    @challenge_preference ||= @challenge.preferences.find(params[:id])
  end
  
  def update
    @challenge_preference ||= @challenge.preferences.find(params[:id])
    if @challenge_preference.update_attributes(params[:challenge_preference])
      flash[:notice] = "Successfully updated preferences."
      redirect_to @challenge
    else
      render 'edit'
    end
  end
  
  def toggle_hidden
    @challenge_preference ||= @challenge.preferences.find(params[:id])
    @challenge_preference.toggle!(:hidden)
    redirect_to :back
  end
  
#  def destroy
#    @challenge_preference ||= @challenge.preferences.find(params[:id])
#    @challenge_preference.destroy
#    flash[:notice] = "Successfully destroyed challenge preference."
#    redirect_to challenge_preferences_url
#  end
  
  private
#    nested resource params always challenge_id
    def instantiate_challenge
      @challenge = Challenge.find(params[:challenge_id])
      @challenge_preference = @challenge.preferences.find(params[:id])
    end
    
    #    only current_friend can view or modify
#    def authorize
#      @challenge ||= Challenge.find(params[:challenge_id])
#      @challenge_preference = @challenge.preferences.find(params[:id])
#      render(:text => 'Unauthorized', :status => 401) unless @challenge_preference.friend == current_friend
#    end
end
