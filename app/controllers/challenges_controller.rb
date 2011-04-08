class ChallengesController < ApplicationController
  before_filter :mash_current_friend_into_params, :only => [:create, :update]
#  before_filter :authorize, :only => [:show, :edit, :update, :destroy]
  before_filter :find_by_hashed_id, :only => [:accept]
  load_resource :except => ['auto_complete_for_challenge_challenged_email']
  authorize_resource :except => ['index', 'new', 'create', 'auto_complete_for_challenge_challenged_email']

  def index
    where = \
    if current_friend.show_hidden_challenges?
      ["(challenger_id = ? or challenged_id = ?) and challenge_preferences.friend_id = ?", *([current_friend.id] * 3)]
    else
      ["challenge_preferences.hidden = ? and (challenger_id = ? or challenged_id = ?) and challenge_preferences.friend_id = ?", false, *([current_friend.id] * 3)]
    end
    @challenges = Challenge.paginate(:page => params[:page], :joins => :preferences, :order => 'challenges.updated_at DESC', :conditions => where)
  end
  
  def show
  end
  
  def new
#    if coming from contact list
    if params[:recipient_id]
      recipient = current_friend.contacts.detect{|contact| contact.hashed_id == params[:recipient_id]}
      @challenge = (recipient ? Challenge.new(:challenged_id => recipient.id) : Challenge.new)
    else
      @challenge = Challenge.new
    end
  end
  
  def create
#    @challenge = Challenge.new(params[:challenge])
    if @challenge.save
      flash[:notice] = "Successfully created challenge."
      redirect_to @challenge
    else
      render 'new'
    end
  end
  
  def edit
#    @challenge ||= Challenge.find(params[:id])
  end
  
  def update
#    @challenge ||= Challenge.find(params[:id])
    if @challenge.update_attributes(params[:challenge])
      flash[:notice] = "Successfully updated challenge."
      redirect_to @challenge
    else
      render 'edit'
    end
  end
  
  def accept
#    @challenge = Challenge.find_by_hashed_id(params[:id])
#    if @challenge.challenged != current_friend
#      raise CanCan::AccessDenied, "Denied, sucka!!"
#    end
    @challenge.toggle!(:accepted)
    flash[:notice] = "Challenge #{(@challenge.accepted? ? 'accepted!' : 'not accepted')}"
    redirect_to challenges_path
  end
  
  def auto_complete_for_challenge_challenged_email
    p = params[:search]
    @friends = current_friend.bets.select { |challenge| challenge.challenged.name.match(/#{p}/i) || challenge.challenged.email.match(/#{p}/i) }.map { |challenge| challenge.challenged }
    @friends.concat( current_friend.challenges.select { |challenge| challenge.challenger.name.match(/#{p}/i) || challenge.challenger.email.match(/#{p}/i) }.map { |challenge| challenge.challenger } )
    render :inline => "<%= auto_complete_result(@friends.uniq, 'email', params[:search]) %>"
  end
  
  protected
    def mash_current_friend_into_params
      params[:challenge][:challenger_id] = current_friend.id
    end
    
    def find_by_hashed_id
      @challenge = Challenge.find_by_hashed_id(params[:id])
    end
end
