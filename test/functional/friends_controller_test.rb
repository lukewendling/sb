require 'test_helper'

class FriendsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Friend.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Friend.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
    assert_equal assigns['friend'].id, session['friend_id']
  end
end
