class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user
    
    if user.karma >= 200 
      can :downvote, Story
      can :downvote, Commnent
    end
  end
end
