class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, :to => :crud
    can :manage, Project, :user_id => user.id
    can :crud, Project
  end
end
