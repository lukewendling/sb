# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  include ExceptionNotifiable

  helper :all # include all helpers, all the time
  protect_from_forgery :secret => 'boston loves pigs' # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  before_filter :login_required
  before_filter :prepare_for_mobile
    
  #rescue twitter gem auth errors globally
  rescue_from Twitter::Unauthorized, :with => :twitter_unauthorized
  
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

   def prepare_for_mobile  
     session[:mobile_param] = params[:mobile] if params[:mobile]
     request.format = :mobile if mobile_device?
   end 
end
