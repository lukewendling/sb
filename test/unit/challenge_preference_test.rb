require 'test_helper'

class ChallengePreferenceTest < ActiveSupport::TestCase
  should_belong_to :challenge, :friend
end
