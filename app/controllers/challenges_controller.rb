class ChallengesController < ApplicationController
  before_filter :mash_current_friend_into_params, :only => [:create, :update]
  before_filter :authorize, :only => [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  def index
#    TODO: WTF? current_friend.challenges pukes on page refresh
    @challenges = Challenge.paginate(:page => params[:page], :order => 'updated_at DESC', :conditions => ["challenger_id = ? or challenged_id = ?", current_friend.id, current_friend.id])
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
  
  def auto_complete_for_challenge_challenged_email
    p = params[:challenge][:challenged_email]
    debugger
    @email_addrs = current_friend.bets.select { |challenge| (challenge.challenged.name.downcase == p.downcase) || (challenge.challenged.email.downcase == p.downcase) }.map { |challenge| "challenge.challenged.name <challenge.challenged.email>" }
    @email_addrs.concat( current_friend.challenges.select { |challenge| (challenge.challenger.name.downcase == p.downcase) || (challenge.challenger.email.downcase == p.downcase) }.map { |challenge| "challenge.challenger.name <challenge.challenger.email>" } )
    render :inline => "<%= auto_complete_result @email_addrs, 'challenged_email', p %>"
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
