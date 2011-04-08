require 'test_helper'

class ChallengeCommentsControllerTest < ActionController::TestCase
  context "for a challenge," do
    setup do
      @challenge = challenges(:linwood_to_luke)
      @challenge_comment = @challenge.comments.first
      login_with('linwood', 'secret')
    end
    
    context "index action" do
      should "render index template" do
        get :index, :challenge_id => @challenge
        assert_template 'index'
      end
    end
    
    context "show action" do
      should "render show template" do
        get :show, :id => @challenge_comment, :challenge_id => @challenge
        assert_template 'show'
      end
    end
    
    context "new action" do
      should "render new template" do
        get :new, :challenge_id => @challenge
        assert_template 'new'
      end
    end
    
    context "create action" do
      should "render new template when model is invalid" do
        ChallengeComment.any_instance.stubs(:valid?).returns(false)
        post :create, :challenge_id => @challenge
        assert_template 'new'
      end
      
      should "redirect when model is valid" do
        ChallengeComment.any_instance.stubs(:valid?).returns(true)
        post :create, :challenge_id => @challenge
        assert_response :redirect
      end
    end
    
    context "edit action" do
      should "render edit template" do
        get :edit, :id => @challenge_comment, :challenge_id => @challenge
        assert_template 'edit'
      end
    end
    
    context "update action" do
      should "render edit template when model is invalid" do
        ChallengeComment.any_instance.stubs(:valid?).returns(false)
        put :update, :id => @challenge_comment, :challenge_id => @challenge
        assert_template 'edit'
      end
    
      should "redirect when model is valid" do
        ChallengeComment.any_instance.stubs(:valid?).returns(true)
        put :update, :id => @challenge_comment, :challenge_id => @challenge
        assert_redirected_to [@challenge, @challenge_comment]
      end
    end
  end
end
