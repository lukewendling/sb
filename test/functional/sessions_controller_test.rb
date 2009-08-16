require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Friend.stubs(:authenticate).returns(nil)
    post :create
    assert_template 'new'
    assert_nil session['friend_id']
  end
  
  def test_create_valid
    Friend.stubs(:authenticate).returns(Friend.first)
    post :create
    assert_redirected_to root_url
    assert_equal Friend.first.id, session['friend_id']
  end
end
