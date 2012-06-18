class Ability
  include CanCan::Ability

  def initialize(user)
   
   if user
     
     can :manage, Subscription, {user_id: user.id}
     
   end
    
    can :read, Plan
    
  end
  
end