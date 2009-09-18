require 'test_helper'

class ChallengesControllerTest < ActionController::TestCase
  
  def setup
    @challenge = challenges(:linwood_to_luke)
    login_with('linwood', 'secret')
  end
  
  def test_index
    get :index
    assert_not_nil assigns(:challenges)
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => @challenge.id
    assert_not_nil assigns(:challenge)
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
    assert_select 'form'
  end
  
  def test_create_invalid
    Challenge.any_instance.stubs(:valid?).returns(false)
    post :create, :challenge => {}
    assert_template 'new'
  end
  
  def test_create_valid
    Challenge.any_instance.stubs(:valid? => true, :save => true)
    post :create, :challenge => {}
#    stubbing :save means @challenge doesn't have an id
#    assert_redirected_to challenge_url(assigns(:challenge))
    assert_match /Successfully created challenge/, flash[:notice]
  end
  
  def test_edit
    get :edit, :id => @challenge.id
    assert_template 'edit'
    assert_select 'form'
  end
  
  def test_update_invalid
    Challenge.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @challenge.id, :challenge => {}
    assert_template 'edit'
  end
  
  def test_update_valid
    Challenge.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @challenge.id, :challenge => {}
    assert_redirected_to challenge_url(assigns(:challenge))
    assert_match /Successfully updated challenge/, flash[:notice]
  end
  
#  def test_destroy
#    challenge = Challenge.first
#    delete :destroy, :id => challenge
#    assert_redirected_to challenges_url
#    assert !Challenge.exists?(challenge.id)
#  end
end
