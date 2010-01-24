require 'test_helper'

class ForgotPasswordTest < ActiveSupport::TestCase
  should_validate_presence_of :email
  should_have_instance_methods :email
end
