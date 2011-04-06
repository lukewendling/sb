module Mobilize
  def self.included(base)
    base.class_eval do
      base.send(:before_filter, :mobilize)
      base.send(:helper_method, :mobile_device?)
    end
  end

  def mobile_device?
    request.user_agent =~ /Mobile|webOS/  
  end
  
  def toggle_mobile_rendering
    session[:mobilize] = session[:mobilize] ? nil : true 
    redirect_to root_path
  end

  private

    def mobile_version_missing
      if mobile_device?
        flash[:notice] = "Sorry, the mobile version of the page you requested has not been created. You'll have to use the plain ol' classic version for now..."
        #TODO: gracefully redirect. this fails
        redirect_to request.path
      else
        raise $!
      end
    end
    
    def mobilize
      request.format = :mobile if mobile_device? or session[:mobilize]
    end
end
