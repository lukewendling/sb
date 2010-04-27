class ChallengeAbility
  include CanCan::Ability

  def initialize(current_friend)
#    Challenge
    can :accept, Challenge do |challenge|
      challenge.challenged == current_friend
    end
    can :read, Challenge do |challenge|
      challenge.friends.include?(current_friend)
    end
    can [:update, :destroy], Challenge, :challenger_id => current_friend.id

#    ChallengeComment 
    can :read, ChallengeComment do |comment|
      comment.challenge.friends.include?(current_friend)
    end
    can [:update, :destroy], ChallengeComment do |comment|
      comment.friend == current_friend
    end
    
#    Friend
    can :update, Friend do |friend|
      friend == current_friend
    end
    
#    ChallengePreference
    can [:update, :destroy, :toggle_hidden], ChallengePreference do |pref|
      pref.friend == current_friend
    end
  end
end

