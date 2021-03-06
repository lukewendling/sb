require 'test_helper'

class FriendTest < ActiveSupport::TestCase
  should_have_many :challenges, :bets, :sent_invitations
  should_belong_to :invitation
  
  def new_friend
    invite = Invitation.new
    invite.sender = @luke
    invite.recipient_email = 'nathanarizona@example.com'
    invite.save!
    
    friend = Friend.new
    friend.username = 'nathanarizona'
    friend.password = '123456'
    friend.email = 'nathanarizona@example.com'
    friend.name = 'Nathan Arizona'
    friend.invitation = invite
    friend.terms_of_use = "1"
    friend.hashed_id = Time.now.to_i
    friend
  end
  
  def setup
    @luke = friends(:luke)
    @linwood = friends(:linwood)
  end
  
  def test_should_have_contacts
    assert !@luke.contacts.empty?
  end
  
  def test_should_be_valid
    assert new_friend.valid?
  end
  
  def test_should_require_username
    @luke.username = ''
    @luke.valid?
    assert @luke.errors.invalid?(:username)
  end
  
  def test_should_require_password
    friend = new_friend
    friend.password = ''
    friend.valid?
    assert friend.errors.invalid?(:password)
  end
  
  def test_should_require_well_formed_email
    @luke.email = 'foo@bar@example.com'
    @luke.valid?
    assert @luke.errors.invalid?(:email)
  end
  
  def test_should_validate_uniqueness_of_email
    friend = new_friend
    friend.email = @luke.email
    friend.valid?
    assert friend.errors.invalid?(:email)
  end
  
  def test_should_validate_uniqueness_of_username
    friend = new_friend
    friend.username = @luke.username
    friend.valid?
    assert friend.errors.invalid?(:username)
  end
  
  def test_should_validate_odd_characters_in_username
    @luke.username = 'odd ^&(@)'
    @luke.valid?
    assert @luke.errors.invalid?(:username)
  end
  
  def test_should_validate_password_length
    @luke.password = 'bad'
    @luke.valid?
    assert @luke.errors.invalid?(:password)
  end
  
  def test_should_require_matching_password_confirmation
    @luke.password_confirmation = 'nonmatching'
    @luke.valid?
    assert @luke.errors.invalid?(:password)
  end
  
  def test_should_generate_password_hash_and_salt_on_create
    friend = new_friend
    friend.save!
    assert friend.password_hash
    assert friend.password_salt
  end
  
  def test_should_authenticate_by_username
    assert_equal @luke, Friend.authenticate(@luke.username, 'secret')
  end
  
  def test_authenticate_by_email
    assert_equal @luke, Friend.authenticate(@luke.email, 'secret')
  end
  
  def test_should_not_authenticate_bad_username
    assert_nil Friend.authenticate('nonexisting', 'secret')
  end
  
  def test_should_not_authenticate_bad_password
    assert_nil Friend.authenticate(@luke.username, 'badpassword')
  end
  
  def test_should_cache_twitter_details
    @luke.twitter_screen_name = ''
    @luke.twitter_profile_image_url = ''
    assert @luke.save 
    assert !@luke.twitter_screen_name.blank?
    assert !@luke.twitter_profile_image_url.blank?
  end
  
  def test_should_notify_inviter
    friend = new_friend
    assert_difference "SentMail.count" do
      assert friend.save
    end
  end
  
  def test_remove_twitter!
    assert @luke.can_tweet?
    @luke.remove_twitter!
    assert !@luke.can_tweet?
  end
  
  def test_should_set_hashed_id
    f = new_friend
    f.valid?
    assert_not_nil f.hashed_id
  end
  
  def test_should_reset_password
    old = @luke.password_hash
    @luke.reset_password!
    assert_not_nil @luke.temp_password
    assert_not_equal old, @luke.password_hash
  end
end
