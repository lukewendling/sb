require 'test_helper'

class TwitterAccountsControllerTest < ActionController::TestCase
  
  def setup
    @linwood = friends(:linwood)
  end
  
  def test_update_should_remove_twitter_account
    assert @linwood.can_tweet?
    
    put :update, {}, :friend_id => @linwood.id
    
    assert !@linwood.reload.can_tweet?
    assert_redirected_to new_authorization_path
  end
  
  def test_create_should_add_twitter_account
    post :create, {}, :friend_id => @linwood.id
    assert_redirected_to new_authorization_path
  end
  
  def test_destroy_should_remove_twitter_account
    assert @linwood.can_tweet?
    
    delete :destroy, {}, :friend_id => @linwood.id
    
    assert !@linwood.reload.can_tweet?
    assert_redirected_to root_path
  end
end
