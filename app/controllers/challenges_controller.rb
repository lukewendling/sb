class ChallengesController < ApplicationController
  before_filter :mash_current_friend_into_params, :only => [:create, :update]
  before_filter :authorize, :only => [:show, :edit, :update, :destroy]
  
  def index
#    TODO: WTF? current_friend.challenges pukes on page refresh
    @challenges = Challenge.all(:conditions => {:challenged_id => current_friend.id})
    @bets = Challenge.all(:conditions => {:challenger_id => current_friend.id})
  end
  
  def show
    @challenge ||= Challenge.find(params[:id])
  end
  
  def new
    @challenge = Challenge.new
  end
  
  def create
    @challenge = Challenge.new(params[:challenge])
    if @challenge.save
      flash[:notice] = "Successfully created challenge."
      redirect_to @challenge
    else
      render 'new'
    end
  end
  
  def edit
    @challenge ||= Challenge.find(params[:id])
  end
  
  def update
    @challenge ||= Challenge.find(params[:id])
    if @challenge.update_attributes(params[:challenge])
      flash[:notice] = "Successfully updated challenge."
      redirect_to @challenge
    else
      render 'edit'
    end
  end
  
#  def destroy
#    @challenge ||= Challenge.find(params[:id])
#    @challenge.destroy
#    flash[:notice] = "Successfully destroyed challenge."
#    redirect_to challenges_url
#  end
  
  def accept
    @challenge = Challenge.find_by_hashed_id(params[:id])
    if @challenge.challenged != current_friend
      render(:text => 'Unauthorized', :status => 401)
    end and return
    @challenge.toggle!(:accepted)
    flash[:notice] = "Challenge #{(@challenge.accepted? ? 'accepted!' : 'not accepted')}"
    redirect_to challenges_path
  end
  
  protected
    def mash_current_friend_into_params
      params[:challenge][:challenger_id] = current_friend.id
    end
    
#    only challenger can update/destroy, friends can view
    def authorize
      @challenge = Challenge.find(params[:id])
      if %w(edit update destroy).include?(action_name)
        render(:text => 'Unauthorized', :status => 401) unless @challenge.challenger == current_friend
      else
        render(:text => 'Unauthorized',:status => 401) unless @challenge.friends.include?(current_friend)
      end
    end
end
