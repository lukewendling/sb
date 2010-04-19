require 'test_helper'

class ChallengeTest < ActiveSupport::TestCase
  should_belong_to :challenger, :challenged, :winner
  should_have_many :comments, :preferences
  
  should_validate_presence_of :hashed_id, :prediction, :event_description #challenger, :challenged

  subject {challenges(:linwood_to_luke)}

  context "A new challenge" do
    setup do
      @new_challenge = challenges(:linwood_to_luke).clone
    end
  
    should "have 2 friends" do
      assert_equal 2, @new_challenge.friends.size
      assert_equal 2, @new_challenge.email_addresses.uniq.size
    end
    
    context "on create" do
      setup do
        assert @new_challenge.save
      end
      
      should_change("The num of sent_mails", :by => 1) {SentMail.count}
      should_change("The num of challenges", :by => 1) {Challenge.count}
      should_change("The num of challenge preferences", :by => 2) {@new_challenge.preferences.size}
      should "set hashed id" do
        assert_not_nil @new_challenge.hashed_id
      end
    end
  end
end
