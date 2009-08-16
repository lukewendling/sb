require 'test_helper'

class ChallengeMailerTest < ActionMailer::TestCase
  test "extend" do
    @expected.subject = 'ChallengeMailer#extend'
    @expected.body    = read_fixture('extend')
    @expected.date    = Time.now

    assert_equal @expected.encoded, ChallengeMailer.create_extend(@expected.date).encoded
  end

end
