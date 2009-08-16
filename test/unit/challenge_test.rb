require 'test_helper'

class ChallengeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Challenge.new.valid?
  end
end
