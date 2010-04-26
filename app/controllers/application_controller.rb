# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  include ExceptionNotifiable

  helper :all # include all helpers, all the time
  protect_from_forgery # :secret => 'boston loves pigs' # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  before_filter :login_required
  before_filter :prepare_for_mobile
    
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

  def mobile_device?  
    if session[:mobile_param]  
      session[:mobile_param] == "1"  
    else  
      request.user_agent =~ /Mobile|webOS/  
    end  
  end  
  helper_method :mobile_device?
  
  private
    def twitter_unauthorized(exception)
      redirect_to new_authorization_url
    end

    def mobile_version_missing
      if mobile_device?
        flash[:notice] = "Sorry, the mobile version of the page you requested has not been created. You'll have to use the plain ol' classic version for now..."
        redirect_to request.path + "?mobile=0"
      else
        raise $!
      end
    end
    
    def prepare_for_mobile  
     session[:mobile_param] = params[:mobile] if params[:mobile]
     request.format = :mobile if mobile_device?
    end 
end
