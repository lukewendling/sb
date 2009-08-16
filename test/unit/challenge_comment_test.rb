require 'test_helper'

class ChallengeCommentTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ChallengeComment.new.valid?
  end
end
