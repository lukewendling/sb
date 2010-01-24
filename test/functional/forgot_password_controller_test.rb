require 'test_helper'

class ForgotPasswordControllerTest < ActionController::TestCase
  context "index action" do
    should "render new template" do
      get :index
      assert_template 'new'
    end
  end
  
  context "new action" do
    should "render new template" do
      get :new
      assert_template 'new'
    end
  end
  
  context "create action" do
    setup do
      @luke = friends(:luke)
    end
    
    should "render new template when model is invalid" do
      ForgotPassword.any_instance.stubs(:valid?).returns(false)
      post :create
      assert_template 'new'
    end
    
    should "redirect when model is valid" do
      ForgotPassword.any_instance.stubs(:valid?).returns(true)
      post :create, :forgot_password => {:email => @luke.email}
      assert_redirected_to login_path
    end
    
    should "render new template when email is unknown" do
      ForgotPassword.any_instance.stubs(:valid?).returns(true)
      post :create, :forgot_password => {:email => 'bogus@nowhere.com'}
      assert_template 'new'
    end
  end

end
