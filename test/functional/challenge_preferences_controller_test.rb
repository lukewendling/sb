require 'test_helper'

class ChallengePreferencesControllerTest < ActionController::TestCase
  
  def setup
    @challenge = challenges(:linwood_to_luke)
    luke = friends(:luke)
    @pref = @challenge.preferences.detect { |p| p.friend == luke }
    login_with('luke', 'secret')
  end
  
  def test_edit
    get :edit, :challenge_id => @challenge.id, :id => @pref.id
    assert_template 'edit'
  end
  
  def test_update_invalid
    ChallengePreference.any_instance.stubs(:valid?).returns(false)
    put :update, :challenge_id => @challenge.id, :id => @pref.id, :challenge_preference => {}
    assert_template 'edit'
  end
  
  def test_update_valid
    ChallengePreference.any_instance.stubs(:valid?).returns(true)
    put :update, :challenge_id => @challenge.id, :id => @pref.id, :challenge_preference => {}
    assert_redirected_to @challenge
  end
end
