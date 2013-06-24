class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user
    
    if user.karma >= 200 
      can :downvote, Story
      can :downvote, Commnent
    end

    if user.role == "admin"
      can :manage, :all
    else
      can [:index, :user_stories, :create, :new, :newest, :calender, :user_stories, :show], Story
      can [:index, :new, :newest, :create, :show], Comment
      can [:index, :show], User
      cannot [:update, :edit, :destory], :all unless user.role == "author"
    end

  end
end
