class ChallengeCommentsController < ApplicationController
  expose :challenge
  expose( :challenge_comments ) { challenge.comments }
  expose :challenge_comment
  
  # TODO: remove cancan load_resource once it plays nicely with decent_exposure. all views should now be using method interfaces, not instance vars.
  load_and_authorize_resource :only => [:show, :edit, :update]
  
  def index
    @challenge_comments = ChallengeComment.paginate_by_challenge_id(challenge.id, :page => params[:page], :order => 'created_at DESC')
  end
  
  def create
    challenge_comment.friend = current_friend
    if challenge_comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to [challenge, challenge_comment]
    else
      render 'new'
    end
  end
  
  def update
    if challenge_comment.update_attributes(params[:challenge_comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to [challenge, challenge_comment]
    else
      render 'edit'
    end
  end
end
