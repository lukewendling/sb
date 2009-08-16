require 'test_helper'

class MailFetcherTest < ActiveSupport::TestCase
  def setup
    @challenge = challenges(:linwood_to_luke)
    @mail = TMail::Mail.new
    @mail.subject = 'Test'
    @mail.content_type = 'text/html'
    @mail.from = @challenge.email_addresses.first
    @mail.to = @challenge.email_addresses.last
    @mail.body = <<-EOB
    a new comment
    
    Reply above this line
    ---------------------
    original comment
    
    ||abc||
    EOB
  end
  
  def test_should_add_challenge_comment
    assert_difference "@challenge.comments(true).count" do
      MailFetcher.receive(@mail)
    end
  end
end
