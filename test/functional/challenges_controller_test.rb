require 'test_helper'

class ChallengesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Challenge.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Challenge.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Challenge.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to challenge_url(assigns(:challenge))
  end
  
  def test_edit
    get :edit, :id => Challenge.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Challenge.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Challenge.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Challenge.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Challenge.first
    assert_redirected_to challenge_url(assigns(:challenge))
  end
  
  def test_destroy
    challenge = Challenge.first
    delete :destroy, :id => challenge
    assert_redirected_to challenges_url
    assert !Challenge.exists?(challenge.id)
  end
end
