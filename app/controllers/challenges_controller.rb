class ChallengesController < ApplicationController
  before_filter :mash_current_friend_into_params, :only => [:create, :update]
  before_filter :authorize, :only => [:show, :edit, :update, :destroy]
  
  def index
    where = \
    if current_friend.show_hidden_challenges?
      ["(challenger_id = ? or challenged_id = ?) and challenge_preferences.friend_id = ?", *([current_friend.id] * 3)]
    else
      ["challenge_preferences.hidden = ? and (challenger_id = ? or challenged_id = ?) and challenge_preferences.friend_id = ?", false, *([current_friend.id] * 3)]
    end
    @challenges = Challenge.paginate(:page => params[:page], :joins => :preferences, :order => 'challenge_preferences.flagged DESC, updated_at DESC', :conditions => where)
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
      render :action => 'new'
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
      render :action => 'edit'
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
