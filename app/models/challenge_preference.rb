class ChallengePreference < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :friend
end
