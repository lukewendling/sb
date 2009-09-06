require 'test_helper'

class TwitterAccountsControllerTest < ActionController::TestCase
  
  def setup
    @linwood = friends(:linwood)
  end
  
  def test_update_should_remove_twitter_account
    assert @linwood.can_tweet?
    
    post :update, {}, :friend_id => @linwood.id
    
    assert !@linwood.reload.can_tweet?
    assert_redirected_to root_path
  end
end
