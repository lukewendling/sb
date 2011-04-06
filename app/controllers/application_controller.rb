# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  include ExceptionNotifiable
  include Mobilize

  helper :all # include all helpers, all the time
  protect_from_forgery # :secret => 'boston loves pigs' # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  before_filter :login_required
    
  #rescue twitter gem auth errors globally
  rescue_from Twitter::Unauthorized, :with => :twitter_unauthorized
  rescue_from ActionView::MissingTemplate, :with => :mobile_version_missing
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to pages_url(:oops)
  end

#  override cancan defaults
  def current_ability
    @current_ability ||= ChallengeAbility.new(current_friend)
  end

  def boom
    raise 'boom'
  end
  
  private
    def twitter_unauthorized(exception)
      redirect_to new_authorization_url
    end
end
