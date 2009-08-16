require 'test_helper'

class FriendTest < ActiveSupport::TestCase
  def new_friend(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    friend = Friend.new(attributes)
    friend.valid? # run validations
    friend
  end
  
  def setup
    Friend.delete_all
  end
  
  def test_valid
    assert new_friend.valid?
  end
  
  def test_require_username
    assert new_friend(:username => '').errors.on(:username)
  end
  
  def test_require_password
    assert new_friend(:password => '').errors.on(:password)
  end
  
  def test_require_well_formed_email
    assert new_friend(:email => 'foo@bar@example.com').errors.on(:email)
  end
  
  def test_validate_uniqueness_of_email
    new_friend(:email => 'bar@example.com').save!
    assert new_friend(:email => 'bar@example.com').errors.on(:email)
  end
  
  def test_validate_uniqueness_of_username
    new_friend(:username => 'uniquename').save!
    assert new_friend(:username => 'uniquename').errors.on(:username)
  end
  
  def test_validate_odd_characters_in_username
    assert new_friend(:username => 'odd ^&(@)').errors.on(:username)
  end
  
  def test_validate_password_length
    assert new_friend(:password => 'bad').errors.on(:password)
  end
  
  def test_require_matching_password_confirmation
    assert new_friend(:password_confirmation => 'nonmatching').errors.on(:password)
  end
  
  def test_generate_password_hash_and_salt_on_create
    friend = new_friend
    friend.save!
    assert friend.password_hash
    assert friend.password_salt
  end
  
  def test_authenticate_by_username
    Friend.delete_all
    friend = new_friend(:username => 'foobar', :password => 'secret')
    friend.save!
    assert_equal friend, Friend.authenticate('foobar', 'secret')
  end
  
  def test_authenticate_by_email
    Friend.delete_all
    friend = new_friend(:email => 'foo@bar.com', :password => 'secret')
    friend.save!
    assert_equal friend, Friend.authenticate('foo@bar.com', 'secret')
  end
  
  def test_authenticate_bad_username
    assert_nil Friend.authenticate('nonexisting', 'secret')
  end
  
  def test_authenticate_bad_password
    Friend.delete_all
    new_friend(:username => 'foobar', :password => 'secret').save!
    assert_nil Friend.authenticate('foobar', 'badpassword')
  end
end
