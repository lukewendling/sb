class ForgotPasswordController < ApplicationController
  skip_before_filter :login_required
  
  def index
    new
    render :action => 'new'
  end
  
  def new
    @forgot_password = ForgotPassword.new
  end
  
  def create
    @forgot_password = ForgotPassword.new(params[:forgot_password])
    if @forgot_password.valid?
      @friend = Friend.find_by_email(@forgot_password.email)
      unless @friend
        flash.now[:error] = "Sorry, that email address is not registered."
        render :action => 'new' and return
      end
      @friend.reset_password!
      flash[:notice] = "Password reset and sent. Please check your Spam folder if you don't receive an email in the next few minutes."
      redirect_to login_path
    else
      render :action => 'new'
    end
  end
end
