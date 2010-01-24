require 'test_helper'

class ApplicationMailerTest < ActiveSupport::TestCase
  should "serialize sent mail" do
    assert_difference "SentMail.count" do
      ChallengerMailer.deliver_the_challenge(Challenge.first)
    end
  end
end
