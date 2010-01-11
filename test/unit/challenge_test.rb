require 'test_helper'

class ChallengeTest < ActiveSupport::TestCase
  should_belong_to :challenger, :challenged, :winner
  should_have_many :comments, :preferences
  
  should_validate_presence_of :challenger, :hashed_id, :prediction #,:challenged
  
  def setup
    @challenge = challenges(:linwood_to_luke)
  end
  
  context "A new challenge" do
    setup do
      @new_challenge = @challenge.clone
    end
  
    should "have 2 friends" do
      assert_equal 2, @new_challenge.friends.size
      assert_equal 2, @new_challenge.email_addresses.uniq.size
    end
    
    context "on create" do
      setup do
        assert @new_challenge.save
      end
      
      should_change "::ActionMailer::Base.deliveries.size", :by => 1
      should_change "Challenge.count", :by => 1
      should_change "@new_challenge.preferences.size", :by => 2
      should "set hashed id" do
        assert_not_nil @new_challenge.hashed_id
      end
    end
  end
end
