class ChallengeCommentsController < ApplicationController
  before_filter :instantiate_challenge
  before_filter :authorize, :only => [:index, :show, :edit, :update, :destroy]
  
  def index
    @challenge_comments = ChallengeComment.paginate_by_challenge_id(@challenge.id, :page => params[:page], :order => 'created_at DESC')
  end
  
  def show
    @challenge_comment ||= @challenge.comments.find(params[:id])
  end
  
  def new
    @challenge_comment = @challenge.comments.build
  end
  
  def create
    @challenge_comment = @challenge.comments.build(params[:challenge_comment])
    @challenge_comment.friend = current_friend
    if @challenge_comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to challenge_comment_path(@challenge, @challenge_comment)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @challenge_comment ||= @challenge.comments.find(params[:id])
  end
  
  def update
    @challenge_comment ||= @challenge.comments.find(params[:id])
    if @challenge_comment.update_attributes(params[:challenge_comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to challenge_comment_path(@challenge, @challenge_comment)
    else
      render :action => 'edit'
    end
  end
  
#  def destroy
#    @challenge_comment ||= @challenge.comments.find(params[:id])
#    @challenge_comment.destroy
#    flash[:notice] = "Successfully destroyed challenge comment."
#    redirect_to challenge_comments_url
#  end
  
  private
#    nested resource params always challenge_id
    def instantiate_challenge
      @challenge = Challenge.find(params[:challenge_id])
    end
    
    #    only challenger can update/destroy, friends can view
    def authorize
      @challenge ||= Challenge.find(params[:challenge_id])
      @challenge_comment = @challenge.comments.find(params[:id])
      if %w(edit update destroy).include?(action_name)
        render(:text => 'Unauthorized', :status => 401) unless @challenge_comment.friend == current_friend
      else
        render(:text => 'Unauthorized',:status => 401) unless @challenge.friends.include?(current_friend)
      end
    end
end
